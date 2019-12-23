srcdir = /home/weijian/projects/php-7.2.10/ext/gd
builddir = /home/weijian/projects/php-7.2.10/ext/gd
top_srcdir = /home/weijian/projects/php-7.2.10/ext/gd
top_builddir = /home/weijian/projects/php-7.2.10/ext/gd
EGREP = /usr/bin/grep -E
SED = /usr/bin/sed
CONFIGURE_COMMAND = './configure' '--with-curl=DIR'
CONFIGURE_OPTIONS = '--with-curl=DIR'
SHLIB_SUFFIX_NAME = so
SHLIB_DL_SUFFIX_NAME = so
ZEND_EXT_TYPE = zend_extension
RE2C = exit 0;
AWK = gawk
shared_objects_gd = gd.lo libgd/gd.lo libgd/gd_gd.lo libgd/gd_gd2.lo libgd/gd_io.lo libgd/gd_io_dp.lo libgd/gd_io_file.lo libgd/gd_ss.lo libgd/gd_io_ss.lo libgd/gd_webp.lo libgd/gd_png.lo libgd/gd_jpeg.lo libgd/gdxpm.lo libgd/gdfontt.lo libgd/gdfonts.lo libgd/gdfontmb.lo libgd/gdfontl.lo libgd/gdfontg.lo libgd/gdtables.lo libgd/gdft.lo libgd/gdcache.lo libgd/gdkanji.lo libgd/wbmp.lo libgd/gd_wbmp.lo libgd/gdhelpers.lo libgd/gd_topal.lo libgd/gd_gif_in.lo libgd/gd_xbm.lo libgd/gd_gif_out.lo libgd/gd_security.lo libgd/gd_filter.lo libgd/gd_pixelate.lo libgd/gd_rotate.lo libgd/gd_color_match.lo libgd/gd_transform.lo libgd/gd_crop.lo libgd/gd_interpolation.lo libgd/gd_matrix.lo libgd/gd_bmp.lo
PHP_PECL_EXTENSION = gd
GDLIB_CFLAGS = -I/home/weijian/projects/php-7.2.10/ext/gd/libgd -DHAVE_LIBPNG
GD_SHARED_LIBADD = -lpng -lz
PHP_MODULES = $(phplibdir)/gd.la
PHP_ZEND_EX =
all_targets = $(PHP_MODULES) $(PHP_ZEND_EX)
install_targets = install-modules install-headers
prefix = /usr/local/php
exec_prefix = $(prefix)
libdir = ${exec_prefix}/lib
prefix = /usr/local/php
phplibdir = /home/weijian/projects/php-7.2.10/ext/gd/modules
phpincludedir = /usr/local/php/include/php
CC = cc
CFLAGS = -g -O2
CFLAGS_CLEAN = $(CFLAGS)
CPP = cc -E
CPPFLAGS = -DHAVE_CONFIG_H
CXX =
CXXFLAGS =
CXXFLAGS_CLEAN = $(CXXFLAGS)
EXTENSION_DIR = /usr/local/php/lib/php/extensions/no-debug-non-zts-20170718
PHP_EXECUTABLE = /usr/local/php/bin/php
EXTRA_LDFLAGS =
EXTRA_LIBS =
INCLUDES = -I/usr/local/php/include/php -I/usr/local/php/include/php/main -I/usr/local/php/include/php/TSRM -I/usr/local/php/include/php/Zend -I/usr/local/php/include/php/ext -I/usr/local/php/include/php/ext/date/lib
LFLAGS =
LDFLAGS =
SHARED_LIBTOOL =
LIBTOOL = $(SHELL) $(top_builddir)/libtool
SHELL = /bin/sh
INSTALL_HEADERS = ext/gd/ ext/gd/libgd/
mkinstalldirs = $(top_srcdir)/build/shtool mkdir -p
INSTALL = $(top_srcdir)/build/shtool install -c
INSTALL_DATA = $(INSTALL) -m 644

DEFS = -DPHP_ATOM_INC -I$(top_builddir)/include -I$(top_builddir)/main -I$(top_srcdir)
COMMON_FLAGS = $(DEFS) $(INCLUDES) $(EXTRA_INCLUDES) $(CPPFLAGS) $(PHP_FRAMEWORKPATH)

all: $(all_targets)
	@echo
	@echo "Build complete."
	@echo "Don't forget to run 'make test'."
	@echo

build-modules: $(PHP_MODULES) $(PHP_ZEND_EX)

build-binaries: $(PHP_BINARIES)

libphp$(PHP_MAJOR_VERSION).la: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(LIBTOOL) --mode=link $(CC) $(CFLAGS) $(EXTRA_CFLAGS) -rpath $(phptempdir) $(EXTRA_LDFLAGS) $(LDFLAGS) $(PHP_RPATHS) $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@
	-@$(LIBTOOL) --silent --mode=install cp $@ $(phptempdir)/$@ >/dev/null 2>&1

libs/libphp$(PHP_MAJOR_VERSION).bundle: $(PHP_GLOBAL_OBJS) $(PHP_SAPI_OBJS)
	$(CC) $(MH_BUNDLE_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS) $(EXTRA_LDFLAGS) $(PHP_GLOBAL_OBJS:.lo=.o) $(PHP_SAPI_OBJS:.lo=.o) $(PHP_FRAMEWORKS) $(EXTRA_LIBS) $(ZEND_EXTRA_LIBS) -o $@ && cp $@ libs/libphp$(PHP_MAJOR_VERSION).so

install: $(all_targets) $(install_targets)

install-sapi: $(OVERALL_TARGET)
	@echo "Installing PHP SAPI module:       $(PHP_SAPI)"
	-@$(mkinstalldirs) $(INSTALL_ROOT)$(bindir)
	-@if test ! -r $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME); then \
		for i in 0.0.0 0.0 0; do \
			if test -r $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME).$$i; then \
				$(LN_S) $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME).$$i $(phptempdir)/libphp$(PHP_MAJOR_VERSION).$(SHLIB_DL_SUFFIX_NAME); \
				break; \
			fi; \
		done; \
	fi
	@$(INSTALL_IT)

install-binaries: build-binaries $(install_binary_targets)

install-modules: build-modules
	@test -d modules && \
	$(mkinstalldirs) $(INSTALL_ROOT)$(EXTENSION_DIR)
	@echo "Installing shared extensions:     $(INSTALL_ROOT)$(EXTENSION_DIR)/"
	@rm -f modules/*.la >/dev/null 2>&1
	@$(INSTALL) modules/* $(INSTALL_ROOT)$(EXTENSION_DIR)

install-headers:
	-@if test "$(INSTALL_HEADERS)"; then \
		for i in `echo $(INSTALL_HEADERS)`; do \
			i=`$(top_srcdir)/build/shtool path -d $$i`; \
			paths="$$paths $(INSTALL_ROOT)$(phpincludedir)/$$i"; \
		done; \
		$(mkinstalldirs) $$paths && \
		echo "Installing header files:          $(INSTALL_ROOT)$(phpincludedir)/" && \
		for i in `echo $(INSTALL_HEADERS)`; do \
			if test "$(PHP_PECL_EXTENSION)"; then \
				src=`echo $$i | $(SED) -e "s#ext/$(PHP_PECL_EXTENSION)/##g"`; \
			else \
				src=$$i; \
			fi; \
			if test -f "$(top_srcdir)/$$src"; then \
				$(INSTALL_DATA) $(top_srcdir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			elif test -f "$(top_builddir)/$$src"; then \
				$(INSTALL_DATA) $(top_builddir)/$$src $(INSTALL_ROOT)$(phpincludedir)/$$i; \
			else \
				(cd $(top_srcdir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i; \
				cd $(top_builddir)/$$src && $(INSTALL_DATA) *.h $(INSTALL_ROOT)$(phpincludedir)/$$i) 2>/dev/null || true; \
			fi \
		done; \
	fi

PHP_TEST_SETTINGS = -d 'open_basedir=' -d 'output_buffering=0' -d 'memory_limit=-1'
PHP_TEST_SHARED_EXTENSIONS =  ` \
	if test "x$(PHP_MODULES)" != "x"; then \
		for i in $(PHP_MODULES)""; do \
			. $$i; $(top_srcdir)/build/shtool echo -n -- " -d extension=$$dlname"; \
		done; \
	fi; \
	if test "x$(PHP_ZEND_EX)" != "x"; then \
		for i in $(PHP_ZEND_EX)""; do \
			. $$i; $(top_srcdir)/build/shtool echo -n -- " -d $(ZEND_EXT_TYPE)=$(top_builddir)/modules/$$dlname"; \
		done; \
	fi`
PHP_DEPRECATED_DIRECTIVES_REGEX = '^(magic_quotes_(gpc|runtime|sybase)?|(zend_)?extension(_debug)?(_ts)?)[\t\ ]*='

test: all
	@if test ! -z "$(PHP_EXECUTABLE)" && test -x "$(PHP_EXECUTABLE)"; then \
		INI_FILE=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r 'echo php_ini_loaded_file();' 2> /dev/null`; \
		if test "$$INI_FILE"; then \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_FILE" > $(top_builddir)/tmp-php.ini; \
		else \
			echo > $(top_builddir)/tmp-php.ini; \
		fi; \
		INI_SCANNED_PATH=`$(PHP_EXECUTABLE) -d 'display_errors=stderr' -r '$$a = explode(",\n", trim(php_ini_scanned_files())); echo $$a[0];' 2> /dev/null`; \
		if test "$$INI_SCANNED_PATH"; then \
			INI_SCANNED_PATH=`$(top_srcdir)/build/shtool path -d $$INI_SCANNED_PATH`; \
			$(EGREP) -h -v $(PHP_DEPRECATED_DIRECTIVES_REGEX) "$$INI_SCANNED_PATH"/*.ini >> $(top_builddir)/tmp-php.ini; \
		fi; \
		TEST_PHP_EXECUTABLE=$(PHP_EXECUTABLE) \
		TEST_PHP_SRCDIR=$(top_srcdir) \
		CC="$(CC)" \
			$(PHP_EXECUTABLE) -n -c $(top_builddir)/tmp-php.ini $(PHP_TEST_SETTINGS) $(top_srcdir)/run-tests.php -n -c $(top_builddir)/tmp-php.ini -d extension_dir=$(top_builddir)/modules/ $(PHP_TEST_SHARED_EXTENSIONS) $(TESTS); \
		TEST_RESULT_EXIT_CODE=$$?; \
		rm $(top_builddir)/tmp-php.ini; \
		exit $$TEST_RESULT_EXIT_CODE; \
	else \
		echo "ERROR: Cannot run tests without CLI sapi."; \
	fi

clean:
	find . -name \*.gcno -o -name \*.gcda | xargs rm -f
	find . -name \*.lo -o -name \*.o | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f
	find . -name \*.so | xargs rm -f
	find . -name .libs -a -type d|xargs rm -rf
	rm -f libphp$(PHP_MAJOR_VERSION).la $(SAPI_CLI_PATH) $(SAPI_CGI_PATH) $(SAPI_MILTER_PATH) $(SAPI_LITESPEED_PATH) $(SAPI_FPM_PATH) $(OVERALL_TARGET) modules/* libs/*

distclean: clean
	rm -f Makefile config.cache config.log config.status Makefile.objects Makefile.fragments libtool main/php_config.h main/internal_functions_cli.c main/internal_functions.c stamp-h buildmk.stamp Zend/zend_dtrace_gen.h Zend/zend_dtrace_gen.h.bak Zend/zend_config.h TSRM/tsrm_config.h
	rm -f php7.spec main/build-defs.h scripts/phpize
	rm -f ext/date/lib/timelib_config.h ext/mbstring/oniguruma/config.h ext/mbstring/libmbfl/config.h ext/oci8/oci8_dtrace_gen.h ext/oci8/oci8_dtrace_gen.h.bak
	rm -f scripts/man1/phpize.1 scripts/php-config scripts/man1/php-config.1 sapi/cli/php.1 sapi/cgi/php-cgi.1 sapi/phpdbg/phpdbg.1 ext/phar/phar.1 ext/phar/phar.phar.1
	rm -f sapi/fpm/php-fpm.conf sapi/fpm/init.d.php-fpm sapi/fpm/php-fpm.service sapi/fpm/php-fpm.8 sapi/fpm/status.html
	rm -f ext/iconv/php_have_bsd_iconv.h ext/iconv/php_have_glibc_iconv.h ext/iconv/php_have_ibm_iconv.h ext/iconv/php_have_iconv.h ext/iconv/php_have_libiconv.h ext/iconv/php_iconv_aliased_libiconv.h ext/iconv/php_iconv_supports_errno.h ext/iconv/php_php_iconv_h_path.h ext/iconv/php_php_iconv_impl.h
	rm -f ext/phar/phar.phar ext/phar/phar.php
	if test "$(srcdir)" != "$(builddir)"; then \
	  rm -f ext/phar/phar/phar.inc; \
	fi
	$(EGREP) define'.*include/php' $(top_srcdir)/configure | $(SED) 's/.*>//'|xargs rm -f

prof-gen:
	CCACHE_DISABLE=1 $(MAKE) PROF_FLAGS=-fprofile-generate all

prof-clean:
	find . -name \*.lo -o -name \*.o | xargs rm -f
	find . -name \*.la -o -name \*.a | xargs rm -f
	find . -name \*.so | xargs rm -f
	rm -f libphp$(PHP_MAJOR_VERSION).la $(SAPI_CLI_PATH) $(SAPI_CGI_PATH) $(SAPI_MILTER_PATH) $(SAPI_LITESPEED_PATH) $(SAPI_FPM_PATH) $(OVERALL_TARGET) modules/* libs/*

prof-use:
	CCACHE_DISABLE=1 $(MAKE) PROF_FLAGS=-fprofile-use all


.PHONY: all clean install distclean test prof-gen prof-clean prof-use
.NOEXPORT:
gd.lo: /home/weijian/projects/php-7.2.10/ext/gd/gd.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/gd.c -o gd.lo 
libgd/gd.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd.c -o libgd/gd.lo 
libgd/gd_gd.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gd.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gd.c -o libgd/gd_gd.lo 
libgd/gd_gd2.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gd2.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gd2.c -o libgd/gd_gd2.lo 
libgd/gd_io.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io.c -o libgd/gd_io.lo 
libgd/gd_io_dp.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io_dp.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io_dp.c -o libgd/gd_io_dp.lo 
libgd/gd_io_file.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io_file.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io_file.c -o libgd/gd_io_file.lo 
libgd/gd_ss.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_ss.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_ss.c -o libgd/gd_ss.lo 
libgd/gd_io_ss.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io_ss.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_io_ss.c -o libgd/gd_io_ss.lo 
libgd/gd_webp.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_webp.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_webp.c -o libgd/gd_webp.lo 
libgd/gd_png.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_png.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_png.c -o libgd/gd_png.lo 
libgd/gd_jpeg.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_jpeg.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_jpeg.c -o libgd/gd_jpeg.lo 
libgd/gdxpm.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdxpm.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdxpm.c -o libgd/gdxpm.lo 
libgd/gdfontt.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontt.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontt.c -o libgd/gdfontt.lo 
libgd/gdfonts.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfonts.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfonts.c -o libgd/gdfonts.lo 
libgd/gdfontmb.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontmb.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontmb.c -o libgd/gdfontmb.lo 
libgd/gdfontl.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontl.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontl.c -o libgd/gdfontl.lo 
libgd/gdfontg.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontg.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdfontg.c -o libgd/gdfontg.lo 
libgd/gdtables.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdtables.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdtables.c -o libgd/gdtables.lo 
libgd/gdft.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdft.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdft.c -o libgd/gdft.lo 
libgd/gdcache.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdcache.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdcache.c -o libgd/gdcache.lo 
libgd/gdkanji.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdkanji.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdkanji.c -o libgd/gdkanji.lo 
libgd/wbmp.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/wbmp.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/wbmp.c -o libgd/wbmp.lo 
libgd/gd_wbmp.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_wbmp.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_wbmp.c -o libgd/gd_wbmp.lo 
libgd/gdhelpers.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdhelpers.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gdhelpers.c -o libgd/gdhelpers.lo 
libgd/gd_topal.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_topal.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_topal.c -o libgd/gd_topal.lo 
libgd/gd_gif_in.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gif_in.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gif_in.c -o libgd/gd_gif_in.lo 
libgd/gd_xbm.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_xbm.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_xbm.c -o libgd/gd_xbm.lo 
libgd/gd_gif_out.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gif_out.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_gif_out.c -o libgd/gd_gif_out.lo 
libgd/gd_security.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_security.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_security.c -o libgd/gd_security.lo 
libgd/gd_filter.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_filter.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_filter.c -o libgd/gd_filter.lo 
libgd/gd_pixelate.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_pixelate.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_pixelate.c -o libgd/gd_pixelate.lo 
libgd/gd_rotate.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_rotate.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_rotate.c -o libgd/gd_rotate.lo 
libgd/gd_color_match.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_color_match.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_color_match.c -o libgd/gd_color_match.lo 
libgd/gd_transform.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_transform.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_transform.c -o libgd/gd_transform.lo 
libgd/gd_crop.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_crop.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_crop.c -o libgd/gd_crop.lo 
libgd/gd_interpolation.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_interpolation.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_interpolation.c -o libgd/gd_interpolation.lo 
libgd/gd_matrix.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_matrix.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_matrix.c -o libgd/gd_matrix.lo 
libgd/gd_bmp.lo: /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_bmp.c
	$(LIBTOOL) --mode=compile $(CC) $(GDLIB_CFLAGS) -I. -I/home/weijian/projects/php-7.2.10/ext/gd $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS)  -c /home/weijian/projects/php-7.2.10/ext/gd/libgd/gd_bmp.c -o libgd/gd_bmp.lo 
$(phplibdir)/gd.la: ./gd.la
	$(LIBTOOL) --mode=install cp ./gd.la $(phplibdir)

./gd.la: $(shared_objects_gd) $(GD_SHARED_DEPENDENCIES)
	$(LIBTOOL) --mode=link $(CC) $(COMMON_FLAGS) $(CFLAGS_CLEAN) $(EXTRA_CFLAGS) $(LDFLAGS) -o $@ -export-dynamic -avoid-version -prefer-pic -module -rpath $(phplibdir) $(EXTRA_LDFLAGS) $(shared_objects_gd) $(GD_SHARED_LIBADD)

