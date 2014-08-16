From: Peter Korsgaard <peter@korsgaard.com>
Subject: Re: [PATCH 2/2] tty: serial: uartlite: Remove .owner field for driver
Date: Sun, 17 Aug 2014 00:23:06 +0200
Message-ID: <87mwb4ysz9.fsf@dell.be.48ers.dk>
References: <54c1e2bd13d6a6e679e1481818d6e068d352ba18.1407930818.git.michal.simek@xilinx.com>
	<54c1e2bd13d6a6e679e1481818d6e068d352ba18.1407930818.git.michal.simek@xilinx.com>
	<4af7dab0dcc8e681b14a5167826e65fb146c5040.1407930818.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54305 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751714AbaHPWXN (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 16 Aug 2014 18:23:13 -0400
In-Reply-To: <4af7dab0dcc8e681b14a5167826e65fb146c5040.1407930818.git.michal.simek@xilinx.com>
	(Michal Simek's message of "Wed, 13 Aug 2014 13:53:43 +0200")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, arnd@arndb.de, Peter Korsgaard <jacmet@sunsite.dk>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Jiri Slaby <jslaby@suse.cz>

>>>>> "Michal" == Michal Simek <michal.simek@xilinx.com> writes:

 > There is no need to init .owner field.
 > Based on the patch from Peter Griffin <peter.griffin@linaro.org>
 > "mmc: remove .owner field for drivers using module_platform_driver"

 > This patch removes the superflous .owner field for drivers which
 > use the module_platform_driver API, as this is overriden in
 > platform_driver_register anyway."

 > Signed-off-by: Michal Simek <michal.simek@xilinx.com>

It would be good with a reference to the commit adding this to
platform_driver_register (9447057eaff8) - But Ok.

Acked-by: Peter Korsgaard <peter@korsgaard.com>

 >  drivers/tty/serial/uartlite.c | 1 -
 >  1 file changed, 1 deletion(-)

 > diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
 > index 9fc22f40796e..189f52e3111f 100644
 > --- a/drivers/tty/serial/uartlite.c
 > +++ b/drivers/tty/serial/uartlite.c
 > @@ -665,7 +665,6 @@ static struct platform_driver ulite_platform_driver = {
 >  	.probe = ulite_probe,
 >  	.remove = ulite_remove,
 >  	.driver = {
 > -		.owner = THIS_MODULE,
 >  		.name  = "uartlite",
 >  		.of_match_table = of_match_ptr(ulite_of_match),
 >  	},
 > --
 > 1.8.2.3


-- 
Bye, Peter Korsgaard
