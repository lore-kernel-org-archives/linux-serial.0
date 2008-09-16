From: "Jaswinder Singh" <jaswinderlinux@gmail.com>
Subject: Re: [Bug #11272] BUG: parport_serial in 2.6.27-rc1 for NetMos Technology PCI 9835
Date: Tue, 16 Sep 2008 20:55:22 +0530
Message-ID: <3f9a31f40809160825s4bd0f950td2b29107113e79e0@mail.gmail.com>
References: <j3zWxt-CgYL.A.WTF.bbsyIB@albercik>
	 <SpS7rta8n4.A.17.FfsyIB@albercik>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:19573 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753730AbYIPPZY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Sep 2008 11:25:24 -0400
Received: by yw-out-2324.google.com with SMTP id 9so807805ywe.1
        for <linux-serial@vger.kernel.org>; Tue, 16 Sep 2008 08:25:23 -0700 (PDT)
In-Reply-To: <SpS7rta8n4.A.17.FfsyIB@albercik>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-serial@vger.kernel.org

Hello all,

I am sorry for delay.

On Sat, Sep 13, 2008 at 12:36 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> Bug-Entry       : http://bugzilla.kernel.org/show_bug.cgi?id=11272
> Subject         : BUG: parport_serial in 2.6.27-rc1 for NetMos Technology PCI 9835
> Submitter       : Jaswinder Singh <jaswinderlinux@gmail.com>
> Date            : 2008-08-05 15:12 (39 days old)
> References      : http://marc.info/?l=linux-kernel&m=121794900319776&w=4
>

I have tested parport_pc and also tried with pcmcia_cs, only thing I
get is disappointment. So I give up :-(

Now I switched to usbserial.
usbserial drivers are working great !!

Now I do not want to use parport_pc and pcmcia_cs atleast for 2 years,
I hope in 2 years this will be solved ;)

In the mean time, If you think my problem is solved just ping to me I
will test and let you know the results.

Thank you for all your support and help.

Jaswinder Singh.
