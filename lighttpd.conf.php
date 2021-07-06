<?php

// Dynamically divide number of desired parallel PHP processes
// into parent and child processes

$procs = isset($argv[1]) && (int)$argv[1]>=1 ? (int)$argv[1] : 2;
$parentProcs = min(4, ($procs % 3 == 0) ? $procs/3 : ceil($procs/2));
$childProcs = ceil($procs/$parentProcs);

?>

## lighttpd configuration file

## Modules to load

server.modules = ("mod_rewrite", "mod_fastcgi", "mod_accesslog")

## where to send error-messages to
server.errorlog             = "/var/log/lighttpd/error.log"

## send a different Server: header
## be nice and keep it at lighttpd
server.tag                 = "lighttpd"

#### accesslog module
accesslog.filename          = "/var/log/lighttpd/access.log"

## to help the rc.scripts
server.pid-file            = "/run/lighttpd.pid"

# change uid to <uid> (default: don't care)
server.username            = "lighttpd"
# change uid to <uid> (default: don't care)
server.groupname           = "lighttpd"

## FastCGI Configuration
fastcgi.server = ( ".php" => (
	"localhost" => (
			"socket" => "/run/lighttpd/php-fastcgi.socket",
			"bin-path" => "/usr/bin/php-cgi",
			"max_procs" => <?php echo $parentProcs; ?>,
			"bin-environment" => (
				"PHP_FCGI_CHILDREN" => "<?php echo $childProcs; ?>",
				"PHP_FCGI_MAX_REQUESTS" => "500"
			)
		)
	)
)

# MIME Types for static files
mimetype.assign  = (
  ".gif"          =>      "image/gif",
  ".jpg"          =>      "image/jpeg",
  ".jpeg"         =>      "image/jpeg",
  ".png"          =>      "image/png",
  ".css"          =>      "text/css",
  ".js"           =>      "text/javascript",
  ".svg"          =>      "image/svg+xml",
  ".pdf"          =>      "application/pdf",
  ".htm"	  =>	  "text/html",
  ".html"	  =>	  "text/html"
)

# Solve problem with 417 errors
server.reject-expect-100-with-417 = "disable"

# URL Rewriting
url.rewrite-if-not-file = ( "^/(.*)" => "/index.php/$1" )

# Document Root
server.document-root = "/var/www/app/web/"
