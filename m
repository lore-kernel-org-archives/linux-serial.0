From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 08/10] serial: pxa: Staticize local symbols
Date: Mon, 12 Aug 2013 11:08:40 -0700
Message-ID: <20130812180840.GB13077@kroah.com>
References: <006401ce9412$d97a34b0$8c6e9e10$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55314 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753299Ab3HLSIl (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 12 Aug 2013 14:08:41 -0400
Content-Disposition: inline
In-Reply-To: <006401ce9412$d97a34b0$8c6e9e10$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org, 'Yi Zhang' <yizhang@marvell.com>, 'Haojun Bao' <hjbao@marvell.com>

On Thu, Aug 08, 2013 at 05:39:51PM +0900, Jingoo Han wrote:
> >From 954e4e864408be296bad2488fb133c2ea163f90f Mon Sep 17 00:00:00 2001
> From: Jingoo Han <jg1.han@samsung.com>
> Date: Thu, 8 Aug 2013 17:15:08 +0900
> Subject: [PATCH 08/10] serial: pxa: Staticize local symbols

Why include this in the message body again?  Please use 'git send-email'
to prevent stuff like this from happening, forcing me to edit the patch
by hand :(

greg k-h
