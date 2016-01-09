From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] tty/serial: atmel: Include module.h to fix build
 failure
Date: Sat, 9 Jan 2016 10:29:08 -0800
Message-ID: <20160109182908.GB29967@kroah.com>
References: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452363335-2535-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
List-Id: linux-serial@vger.kernel.org

On Sat, Jan 09, 2016 at 10:15:35AM -0800, Guenter Roeck wrote:
> If serial/atmel_serial.c is compiled with devicetree enabled, the
> following build error is observed.
> 
> drivers/tty/serial/atmel_serial.c:192:1: warning:
> 	data definition has no type or storage class
> drivers/tty/serial/atmel_serial.c:192:1: error:
> 	type defaults to 'int' in declaration of 'MODULE_DEVICE_TABLE'
> drivers/tty/serial/atmel_serial.c:192:1: warning:
> 	parameter names (without types) in function declaration
> 
> MODULE_DEVICE_TABLE is used to specify devicetree compatibilities.
> 
> Fixes: c39dfebc7798 ("drivers/tty/serial: make serial/atmel_serial.c explicitly non-modular")
> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/tty/serial/atmel_serial.c | 1 +
>  1 file changed, 1 insertion(+)

This hit my tree last night already with commit
041497eb721ddbdc1e690316976dd8ba7bc136a2, so all should be fine in the
next linux-next release.

thanks,

greg k-h
