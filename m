From: "Mike Frysinger" <vapier.adi@gmail.com>
Subject: Re: [PATCH 1/1] serial: RS485 ioctl structure uses __u32 include linux/types.h
Date: Mon, 29 Dec 2008 07:37:04 -0500
Message-ID: <8bd0f97a0812290437m75b7b7f8rf472c5f98870572d@mail.gmail.com>
References: <1228215625-18317-1-git-send-email-apw@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:38677 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750705AbYL2MhF (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 29 Dec 2008 07:37:05 -0500
In-Reply-To: <1228215625-18317-1-git-send-email-apw@canonical.com>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andy Whitcroft <apw@canonical.com>
Cc: Alan Cox <alan@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Dec 2, 2008 at 06:00, Andy Whitcroft <apw@canonical.com> wrote:
> In the commit below a new struct serial_rs485 was introduced for a new
> ioctl:
>
>    commit c26c56c0f40e200e61d1390629c806f6adaffbcc
>    Author: Alan Cox <alan@redhat.com>
>    Date:   Mon Oct 13 10:37:48 2008 +0100
>
>        tty: Cris has a nice RS485 ioctl so we should steal it
>
> This structure uses the __u32 types for some of its members, which leads
> to the following compile error:

looks like this was posted on Nov 3 already ...
http://lkml.org/lkml/2008/11/3/240
-mike
