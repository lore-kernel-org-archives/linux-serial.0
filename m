From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Fix the warning of uninitialized value in
 driver/serial/8250.c
Date: Tue, 3 Feb 2009 17:22:23 +0000
Message-ID: <20090203172223.4ef378d0@the-village.bc.nu>
References: <4986B86E.3030604@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:45836 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbZBCRyt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Feb 2009 12:54:49 -0500
In-Reply-To: <4986B86E.3030604@oracle.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: wenji.huang@oracle.com
Cc: linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Mon, 02 Feb 2009 17:10:06 +0800
Wenji Huang <wenji.huang@oracle.com> wrote:

> This patch is to remove the the warning of uninitialized i in 
> driver/serial/8250.c
> 
> Signed-off-by: Wenji Huang <wenji.huang@oracle.com>

NAK - your gcc is wrong. Use a newer gcc and the warning goes away.

