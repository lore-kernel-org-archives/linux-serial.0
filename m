From: Oleg Kravchenko <oleg@kaa.org.ua>
Subject: pxa serial and gps
Date: Fri, 09 Jan 2009 17:03:24 +0200
Message-ID: <4967673C.7090008@kaa.org.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kaa.org.ua ([193.178.146.73]:52270 "EHLO kaa.org.ua"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbZAIPD2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 9 Jan 2009 10:03:28 -0500
Received: from [10.7.0.100] (unknown [10.7.0.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by kaa.org.ua (Postfix) with ESMTPSA id A432BC1589
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2009 16:54:22 +0200 (EET)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hello! Sorry for my English  ;)  I am a very newbie in kernel developing.
I am porting linux to Asus P535 (details on
http://www.kaa.org.ua/ru/asus-p535/hardware.html)

I have a GPS-device on COM-port. It switches on after supplying the
electricity (I know the commands sequence for making it). I should call
"open()" function to open the port of this device.

My goal is to create the clear switching on of the GPS-device. I mean,
when "open()" function is called for the GPS-port, the commands for
switching GRP-device on shold be additionally executed. I.e. I should
hang the system hook to the "open()" function and analyze the port, for
which "open()" function was called. If it is the GPS-device port I
should call the function of GPS switching on and after that call the
"open()" function by default. Otherwise, I should just call the "open()"
function by default.

I have gps device on /dev/ttyS1 but to use them need enable it by i2c-tools,
I want write some layer code to auto enable gps device when open()
function executing and shutdown gps when close() called

How make it? What function and structures use me?                 
           

I am try to use tty_register_ldisc() but having kernel panic  :-) 

------------------------------------------------------------------------

#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/skbuff.h>
#include <linux/tty.h>
#include <linux/netdevice.h>
#include <linux/poll.h>
#include <linux/ppp_defs.h>
#include <linux/if_ppp.h>
#include <linux/ppp_channel.h>
#include <linux/spinlock.h>
#include <linux/completion.h>
#include <linux/init.h>
#include <asm/uaccess.h>
#include <mach/asusp535.h>

static int asusp535_gps_open(struct tty_struct *tty)
{
	printk("asusp535_gps_open() %s\n", tty->name);

	gpio_set_value(GPIO_ASUSP535_GPS_PWR1, 1);
	gpio_set_value(GPIO_ASUSP535_GPS_PWR2, 1);

	return(0);
}

static void asusp535_gps_close(struct tty_struct *tty)
{
	printk("asusp535_gps_close() %s\n", tty->name);

	gpio_set_value(GPIO_ASUSP535_GPS_PWR2, 0);
	gpio_set_value(GPIO_ASUSP535_GPS_PWR1, 0);
}

static int asusp535_gps_hangup(struct tty_struct *tty)
{
	printk("asusp535_gps_hangup() %s\n", tty->name);

	return(0);
}

static struct tty_ldisc_ops asusp535_gps_ldisc = {
	.owner	= THIS_MODULE,
	.magic	= TTY_LDISC_MAGIC,
	.name	= "gps",
	.open	= asusp535_gps_open,
	.close	= asusp535_gps_close,
	.hangup	= asusp535_gps_hangup,
};

static int __init asusp535_gps_init(void)
{
	int err = tty_register_ldisc(N_TTY, &asusp535_gps_ldisc);

	printk("asusp535_gps_init()\n");

	if(err)
		printk(KERN_ERR "asusp535_gps: error %d registering line disc.\n", err);

	return(err);
}

static void __exit asusp535_gps_cleanup(void)
{
	printk("asusp535_gps_cleanup()\n");

	if(tty_unregister_ldisc(N_TTY))
		printk(KERN_ERR "asusp535_gps: failed to unregister line discipline\n");
}

module_init(asusp535_gps_init);
module_exit(asusp535_gps_cleanup);

MODULE_LICENSE("GPL");

