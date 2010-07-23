From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH 2/2] serial: 8250: remove SERIAL_8250_AU1X00
Date: Fri, 23 Jul 2010 19:31:32 +0200
Message-ID: <AANLkTikG_FCh6DgX1Wwn7o6b2+uBRQz9F6JX=vjzba2k@mail.gmail.com>
References: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
	<1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
	<20100723170205.GB3923@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47511 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756489Ab0GWRbe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2010 13:31:34 -0400
Received: by iwn7 with SMTP id 7so381781iwn.19
        for <linux-serial@vger.kernel.org>; Fri, 23 Jul 2010 10:31:33 -0700 (PDT)
In-Reply-To: <20100723170205.GB3923@linux-mips.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Linux-serial <linux-serial@vger.kernel.org>

On Fri, Jul 23, 2010 at 7:02 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jul 15, 2010 at 09:45:05PM +0200, Manuel Lauss wrote:
>
> Thanks, queued for 2.6.36.
>
> It's probably harmless but there was a fairly large line offset in
> arch/mips/alchemy/common/platform.c so you may want to check that what I
> queued is ok.

It's ok, the offset comes from a few pm-related patches I usually work with.

Thank you!
        Manuel
