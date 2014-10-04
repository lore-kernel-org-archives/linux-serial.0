From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] serial: mxs-auart: add sysrq support
Date: Sat, 4 Oct 2014 13:19:03 -0300
Message-ID: <CAOMZO5Cctk4UNvK2=MC9tf2Fzi1r0+qdn-SXfC-=W9n3T=a+VA@mail.gmail.com>
References: <20140929014129.GA8687@kroah.com>
	<1411999905-27044-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-la0-f46.google.com ([209.85.215.46]:34587 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaJDQTG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 4 Oct 2014 12:19:06 -0400
In-Reply-To: <1411999905-27044-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Janusz,

On Mon, Sep 29, 2014 at 11:11 AM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
>> So I'm deleting all of these now, please resend the latest
>> versions you have, with properly versioning
>> and order information.
>
> Sure. If you don't want to comment dirty patches
> I will not send you them.
> I can send you only the final version, commented before.
>
> On the moment this patch is ready to apply.
>
> [PATCH RESEND] serial: mxs-auart: add sysrq support
> The patch is resent to apply.

What Greg is asking you to do is to provide a proper version
annotation in your patches.

For example: [PATCH v2] serial: mxs-auart: add ...

Then if you need to submit it again you should do:

[PATCH v3] serial: mxs-auart: add ...

Also, always explain below the --- line what changed from one version to another
