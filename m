From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Disregard: [PATCH] tty: Char: mxser, add support for CP114EL
Date: Tue, 02 Mar 2010 22:34:47 +0100
Message-ID: <4B8D8477.8020003@gmail.com>
References: <87bpf6esd7.fsf@osv.gnss.ru> <87r5o24efj.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f219.google.com ([209.85.220.219]:37722 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856Ab0CBVew (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Mar 2010 16:34:52 -0500
Received: by fxm19 with SMTP id 19so838479fxm.21
        for <linux-serial@vger.kernel.org>; Tue, 02 Mar 2010 13:34:50 -0800 (PST)
In-Reply-To: <87r5o24efj.fsf@osv.gnss.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sergei Organov <s.organov@javad.com>
Cc: linux-serial@vger.kernel.org

On 03/02/2010 10:11 PM, Sergei Organov wrote:
> Sergei Organov <osv@javad.com> writes:
>> Add support for MOXA:0x1144 pci device. It's a 4-port device and
>> differs in no way from the others. So this turns out to be a trivial
>> pci_device_id change.
> 
> Please disregard this patch for now. This board doesn't in fact work
> properly with the driver and recognizing it by the driver might lead to
> problems.
> 
> I'll be working on this, -- sorry for the noise.

Yeah, the device you have is handled by different driver which is not
upstream yet, If you really have the card, you can try to merge it and
cleanup e.g. through staging. Note that the driver provided by moxa is
ugly and needs cleanup before moving to drivers/char/. It might be worth
to merge it with mxser (I haven't look into how much similar/different
they are.).
