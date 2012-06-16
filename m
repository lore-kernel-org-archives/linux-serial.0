From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 04/10] fblog: implement fblog_redraw()
Date: Sat, 16 Jun 2012 23:35:26 +0100
Message-ID: <20120616233526.7f830890@pyramind.ukuu.org.uk>
References: <1339884266-9201-1-git-send-email-dh.herrmann@googlemail.com>
	<1339884266-9201-5-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60876 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756952Ab2FPWbp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 16 Jun 2012 18:31:45 -0400
In-Reply-To: <1339884266-9201-5-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-serial@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Sun, 17 Jun 2012 00:04:20 +0200
David Herrmann <dh.herrmann@googlemail.com> wrote:

> This mostly copies the functionality from drivers/video/console/bitblit.c
> so we can draw the console content on all available framebuffers.
> 
> All speed optimizations have been removed for simplicity. The original
> code depends heavily on CONFIG_VT so we cannot share the codebase here.

No. That means we've got two sets of code to maintain not one. Fix the
dependancy.

Pull the relevant subset of struct vc_data into another struct
Make struct vc_data be

struct vc_data {
	struct vc_whatever
	rest
}

Alan
