From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v2 RESEND] serial: mxs-auart: add sysrq support
Date: Fri, 10 Oct 2014 08:37:12 -0300
Message-ID: <CAOMZO5BxR4X69LP8HKHRsVFgmaqwQUv328L6fbu4ZvU-Jp61Uw@mail.gmail.com>
References: <1412939608-19933-1-git-send-email-j.uzycki@elproma.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:56817 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565AbaJJLhO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Oct 2014 07:37:14 -0400
In-Reply-To: <1412939608-19933-1-git-send-email-j.uzycki@elproma.com.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Janusz Uzycki <j.uzycki@elproma.com.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jiri Slaby <jslaby@suse.cz>, Richard Genoud <richard.genoud@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Oct 10, 2014 at 8:13 AM, Janusz Uzycki <j.uzycki@elproma.com.pl> wrote:
> When using mxs-auart based console, sometime we need the sysrq function
> to help debugging kernel. The sysrq code is basically there,
> this patch just simply enable it.
>
> Signed-off-by: Janusz Uzycki <j.uzycki@elproma.com.pl>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
