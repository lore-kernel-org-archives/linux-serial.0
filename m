From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/2] tty/serial: Add PORT_TEGRA, fix break handling for
 it
Date: Tue, 17 May 2011 22:58:25 +0100
Message-ID: <20110517225825.032e9461@lxorguk.ukuu.org.uk>
References: <1305660466-4704-1-git-send-email-swarren@nvidia.com>
	<20110517193836.GA6912@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:33874 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756614Ab1EQV44 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 May 2011 17:56:56 -0400
In-Reply-To: <20110517193836.GA6912@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Stephen Warren <swarren@nvidia.com>, ldewangan@nvidia.com, linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org

> If Alan acks these, I'll be glad to take them through the serial tree as
> normal, or you can take them through the tegra tree.
> 
> Either way, they need Alan's review first.

First one I am fine with. Second is more chip specific goop where we
don't want it. However right at the moment there isn't a magic cure to
that and the port->ops hackery I've been doing isn't done and it's not
reasonable to hold this up waiting for a project with indeterminate
completion date.

Ack #1

Can you add a 

/*
 * FIXME: This needs to become a port specific callback once we have a
 * framework for this
 */

to #2 so it doesn't get forgotten in a future cleanup.

Alan
