Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C92C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 15:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C01B22B49
	for <linux-serial@archiver.kernel.org>; Tue,  5 Jan 2021 15:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbhAEPDe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 Jan 2021 10:03:34 -0500
Received: from bmail1.ministro.hu ([5.249.150.236]:56042 "EHLO
        bmail1.ministro.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAEPDd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 Jan 2021 10:03:33 -0500
Received: from localhost (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTP id 5CBF0122F4D;
        Tue,  5 Jan 2021 16:02:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609858971;
        bh=v350A/6Bd6SJNTcSRSPY7h00OSsm5tIDKCT7HXK1edA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P91yERIXwL03CBiF+YBiKcTK8UVT/NVQbyO55/hzn6XNNy1s3tDT4QfV9KW6nx59n
         ooJ8l6jtqgz8zPHOYHELY3YYDb9x/E6hRgxIin83qxh08kG0sVaMZ1r0Ef4ssTsKAk
         9/pGtpfYwRVTli/2fCgbok0WUB5B18K5kBi65KD5Q0/dkYUqn6IItIZ1A/7CSjvCkJ
         nkvp/C/dnxPgMnDWLmmfiMppXZRpp6YOi3pBlhBRdseohwBYQTsluzzO7Yp6cBjeVQ
         7dq7MqcfvTfqJnO4WI75wKQshj9mAZDETGU0Z4T06HY0sJW/RERjw7cXK8Z0YecnCq
         +StUdJryjhB6A==
X-Virus-Scanned: Debian amavisd-new at ministro.hu
Received: from bmail1.ministro.hu ([127.0.0.1])
        by localhost (bmail1.ministro.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VMTWMPg1Qnta; Tue,  5 Jan 2021 16:02:20 +0100 (CET)
Received: from dev (localhost [127.0.0.1])
        by bmail1.ministro.hu (Postfix) with ESMTPSA id AB9B9122F4A;
        Tue,  5 Jan 2021 16:02:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ministro.hu;
        s=201804; t=1609858940;
        bh=v350A/6Bd6SJNTcSRSPY7h00OSsm5tIDKCT7HXK1edA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oPEEFDxK7bjVVLyQP4TA67RAfBkPh3OzHS8IyNG4Jjv00I1AgqzCgoKgC75CIP7GK
         MhwcmZ6nSrY9ds4cixAnyf1KX3Apz5n5qiCBPZHoOsNO6Up6ZvXCcVqYlGAX4Kpj7R
         CQQu1HA0CSpJrpREqc2iWPuL0Jd1zHO7hLe4MRxShOpHt8snXpVRs+dt7INxfxhwlt
         6JLNFKTInSeeQdeCrP4fYEyO2bY36Kr5GbKJa342q7DgKEsz7idtovKf2QnBr51qus
         NrbgckdhLA280R2iwRFFbg7k/UqlzYvX5rjpfUsbmnlK2gOYfGMTzxj3WvS8oRVhBE
         gxaa6FWmSjkKg==
Date:   Tue, 5 Jan 2021 15:02:15 +0000
From:   =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
To:     'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7,1/2] Serial: silabs si4455 serial driver
Message-ID: <20210105150214.GA6031@dev>
References: <20210105102921.GA10736@dev>
 <X/RpcButq6PhqdIs@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X/RpcButq6PhqdIs@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 05, 2021 at 02:28:16PM +0100, 'Greg Kroah-Hartman' wrote:
> On Tue, Jan 05, 2021 at 10:29:25AM +0000, József Horváth wrote:
> > This is a serial port driver for
> >  Silicon Labs Si4455 Sub-GHz transciver.
> > 
> > The goal of this driver is to removing wires
> >  between central(linux) device and remote serial devices/sensors,
> >  but keeping the original user software.
> >  It represents regular serial interface for the user space.
> > 
> > Datasheet: https://www.silabs.com/documents/public/data-sheets/Si4455.pdf
> > 
> > Guide: https://github.com/dministro/linux-serial-si4455
> > 
> > Signed-off-by: Jozsef Horvath <info@ministro.hu>
> > ---
> > 
> >  
> > +config SERIAL_SI4455
> > +	tristate "Si4455 support"
> > +	depends on SPI
> > +	select SERIAL_CORE
> > +	help
> > +	  This driver is for Silicon Labs's Si4455 Sub-GHz transciver.
> > +	  Say 'Y' here if you wish to use it as serial port.
> > +
> 
> No module name?

Sorry, I dont understand your question. Can you explain it?

> 
> >  endmenu
> > +#include <linux/string.h>
> > +#include <linux/firmware.h>
> > +#include <linux/timer.h>
> > +#ifdef CONFIG_DEBUG_FS
> > +#include <linux/debugfs.h>
> > +#endif
> 
> No need for #ifdef for .h files.
> 

Ok, its clear. I'll remove it from here and below.

> > +
> > +#define PORT_SI4455						1096
> > +#define SI4455_NAME						"Si4455"
> > +#define SI4455_MAJOR						432
> > +#define SI4455_MINOR						567
> 
> Where are these major/minor numbers being used and where did they come
> from?  Why do you need them?
> 
> > +struct si4455_port {
> > +	struct uart_port port;
> > +#ifdef CONFIG_DEBUG_FS
> > +	struct dentry *dbgfs_dir;
> > +#endif
> 
> Do not put #ifdefs in .c code, you never need to check for this type of
> thing.
> 
> > +static struct uart_driver si4455_uart = {
> > +	.owner			= THIS_MODULE,
> > +	.driver_name		= SI4455_NAME,
> > +#ifdef CONFIG_DEVFS_FS
> > +	.dev_name		= "ttySI%d",
> 
> Looks like you are porting this from a _VERY_ old kernel.  That config
> option went away 15+ years ago.  Are you sure this works?
> 

Ok, I'll remove it.

> 
> > +#else
> > +	.dev_name		= "ttySI",
> 
> Where did you get that name from?
> 

This is my suggestion. I dont know the naming rules.

> 
> > +static int si4455_begin_tx(struct uart_port *port, u32 channel, int length,
> > +			   u8 *data)
> > +{
> > +	int ret = 0;
> > +	struct si4455_int_status int_status = { 0 };
> > +	struct si4455_fifo_info fifo_info = { 0 };
> > +
> > +	dev_dbg(port->dev, "%s(%u, %u)\n", __func__, channel, length);
> 
> No need for these types of debugging lines, just use ftrace.
> 
> Please remove them, you have them in a few places (same for the end of
> functions.)
> 
> > +static void si4455_null_void(struct uart_port *port)
> > +{
> > +	/* Do nothing */
> 
> Why do you need this???

I'll check this.

> 
> > +#ifdef CONFIG_DEBUG_FS
> 
> Again, no #ifdef needed.
> 
> > +static int si4455_debugfs_init(struct device *dev)
> > +{
> > +	struct si4455_port *s = dev_get_drvdata(dev);
> > +	struct dentry *dbgfs_si_dir;
> > +	struct dentry *dbgfs_partinfo_dir;
> > +	struct dentry *dbgfs_entry;
> > +
> > +	s->dbgfs_dir = debugfs_create_dir(dev_name(dev), NULL);
> > +	if (IS_ERR(s->dbgfs_dir))
> > +		return PTR_ERR(s->dbgfs_dir);
> 
> No  need to check any debugfs return value, just use it and move on.
> 
> > +
> > +	dbgfs_si_dir = debugfs_create_dir("si4455", s->dbgfs_dir);
> > +	if (IS_ERR(dbgfs_si_dir))
> > +		return PTR_ERR(dbgfs_si_dir);
> > +
> > +	dbgfs_entry = debugfs_create_u32("cts_error_count", 0444,
> > +					 dbgfs_si_dir, &s->cts_error_count);
> > +	if (IS_ERR(dbgfs_entry))
> > +		return PTR_ERR(dbgfs_entry);
> 
> Same for all of these, no need to check anything.

Ok, its clear.

> 
> > +
> > +	dbgfs_entry = debugfs_create_u32("tx_error_count", 0444,
> > +					 dbgfs_si_dir, &s->tx_error_count);
> > +	if (IS_ERR(dbgfs_entry))
> > +		return PTR_ERR(dbgfs_entry);
> > +
> > +	dbgfs_partinfo_dir = debugfs_create_dir("partinfo", dbgfs_si_dir);
> > +	if (IS_ERR(dbgfs_partinfo_dir))
> > +		return PTR_ERR(dbgfs_partinfo_dir);
> > +
> > +	dbgfs_entry = debugfs_create_u8("chip_rev", 0444,
> > +					dbgfs_partinfo_dir,
> > +					&s->part_info.chip_rev);
> 
> Wait, did you even build this code?  Does it work?  It shouldn't, these
> debugfs calls have changed...
> 
> I'm stopping reviewing here.

Working test systems:

- #1 - one Si4455 connected to spi1.2:
 $ uname -r
   4.19.66-v7+

 $ ls -R /sys/kernel/debug/spi1.2/si4455
   /sys/kernel/debug/spi1.2/si4455:
   cts_error_count  partinfo  tx_error_count

   /sys/kernel/debug/spi1.2/si4455/partinfo:
   chip_rev  part  rom_id

 $ ls /dev | grep ttySI
   ttySI0

- #2 - one Si4455 connected to spi0.0 and an other to spi0.1:
 $ uname -r
   5.4.79-v7+

 $ ls -R /sys/kernel/debug/spi0.0/si4455
   /sys/kernel/debug/spi0.0/si4455:
   cts_error_count  partinfo  tx_error_count

   /sys/kernel/debug/spi0.0/si4455/partinfo:
   chip_rev  part  rom_id

 $ ls -R /sys/kernel/debug/spi0.1/si4455
   /sys/kernel/debug/spi0.1/si4455:
   cts_error_count  partinfo  tx_error_count

   /sys/kernel/debug/spi0.1/si4455/partinfo:
   chip_rev  part  rom_id

 $ cat /sys/kernel/debug/spi0.0/si4455/partinfo/chip_rev
   34 <- Its valid

 $ ls /dev | grep ttySI
   ttySI0
   ttySI1

I made a short guide to using the interfaces, generating the firmware and a simple setup.
You can see it: https://github.com/dministro/linux-serial-si4455
I always test, compile, test, compile, test, test, test, checkpatch before sending my patch.

So my answer is yes, but you are right too :)

I found the answer just now, I compiled this for kernel v4.19.66 and v5.4.79 but not for v5.10.

Sorry for this, and thank you for suggestions.

> 
> thanks,
> 
> greg k-h

Üdvözlettel / Best regards:
József Horváth

