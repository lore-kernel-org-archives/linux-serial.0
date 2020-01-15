Return-Path: <SRS0=4AmH=3E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B6C33CB1
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jan 2020 12:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EB12465A
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jan 2020 12:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579092135;
	bh=nSCqvKODAoL0joKlazTXynwBxMDxfJl7wyUtw2MF4Uw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WGrORpD2BMhXKPhxbVCptM0TGHDAlR/xDS1D8ZYVS6DAaePbStWjrnHMECR1RJMVg
	 Ay163KEDO1RAsOpvWX59URQhW0v/ChG3Y0OvsiPJmtIA+XOy83qsAApAJ6fx92FG3z
	 Xe69A3MhDQb7U8KoLLP3VZDp+G/uz9TXX25RN/+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgAOMmP (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:42:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgAOMmN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jan 2020 07:42:13 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D5F22522;
        Wed, 15 Jan 2020 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579092133;
        bh=nSCqvKODAoL0joKlazTXynwBxMDxfJl7wyUtw2MF4Uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KjuBOnTNvH+42s0Re5I/lqzWJeCybk8Hvm0vqAsrClq3TeGojXX8g8bSAiD/mF/jL
         Xlb0Jw+h2ug9g8theJAoWLXVcQ+EvDQXjcJWSPtj0XgJPmw1TA5wUb6mG+kbAgap0Y
         s5DHa8i6hMFZ4l7wzb1QBAzxo+q7UpP2RnUtCR4k=
Date:   Wed, 15 Jan 2020 13:42:10 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Jiri Slaby <jslaby@suse.com>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH-next 3/3] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
Message-ID: <20200115124210.GA3486045@kroah.com>
References: <20200109215444.95995-1-dima@arista.com>
 <20200109215444.95995-4-dima@arista.com>
 <20200110164643.GB1822445@kroah.com>
 <a6a3ee46-9537-c287-b366-797c787c28b6@arista.com>
 <41435a7b-48a2-438c-998a-14481fbc3a1a@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41435a7b-48a2-438c-998a-14481fbc3a1a@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 14, 2020 at 07:10:47PM +0000, Dmitry Safonov wrote:
> On 1/10/20 10:32 PM, Dmitry Safonov wrote:
> > On 1/10/20 4:46 PM, Greg Kroah-Hartman wrote:
> > [..]
> >>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> >>> index 6ac9dfed3423..f70eba032d0b 100644
> >>> --- a/drivers/tty/serial/serial_core.c
> >>> +++ b/drivers/tty/serial/serial_core.c
> >>> @@ -3081,6 +3081,38 @@ void uart_insert_char(struct uart_port *port, unsigned int status,
> >>>  }
> >>>  EXPORT_SYMBOL_GPL(uart_insert_char);
> >>>  
> >>> +const char sysrq_toggle_seq[] = CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE;
> >>> +
> >>> +static void uart_sysrq_on(struct work_struct *w)
> >>> +{
> >>> +	sysrq_toggle_support(1);
> >>> +	pr_info("SysRq is enabled by magic sequience on serial\n");
> >>
> >> Do we want to say what serial port it is enabled on?
> > 
> > Makes sense, will add.
> 
> Ah, I've managed to forget to mention that I didn't add the port name
> into the message in v2. I experimented a bit - it's getting a bit
> complicated how-to protect (char *name) for just this message.
> Like, SysRq can be theoretically enabled on two serials at the same
> moment - so some locking is needed to make the printed name sane.
> 
> As sysrq_toggle_support() is a global-enable knob for sysrq (also can be
> switched in /proc/sys/kernel/sysrq) I'm not sure if it's worth to
> complicate code to print through which serial console SysRq has been
> enabled.
> 
> I can still do it in v3 if you insist.

No worries, if it's too hard to get to, that's fine.  If it was
available, it would have been nice to have.

thanks,

greg k-h
