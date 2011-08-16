From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_pnp: add Intermec CV60 touchscreen device
Date: Tue, 16 Aug 2011 19:24:38 +0100
Message-ID: <20110816192438.1bb11fac@bob.linux.org.uk>
References: <20110816180228.13152.61387.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:13204 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752238Ab1HPSUY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 14:20:24 -0400
In-Reply-To: <20110816180228.13152.61387.stgit@bhelgaas.mtv.corp.google.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, 16 Aug 2011 12:02:28 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> It would have been nice if Intermec had supplied a PNP0501 _CID for
> the COM3 device, but they didn't, so we have to recognize it
> explicitly.

Acked-by: Alan Cox <alan@linux.intel.com>
