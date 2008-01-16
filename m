From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [patch 0/2] serial: explicitly request ttyS0-3 for COM1-4
Date: Wed, 16 Jan 2008 10:05:41 -0700
Message-ID: <20080116170541.511233227@ldl.fc.hp.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:38715 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752619AbYAPRIs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2008 12:08:48 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Russell King <rmk+serial@arm.linux.org.uk>, Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@linux-foundation.org>

When 8250_pnp discovers COM ports, we only get the correct ttyS names
by accident -- we rely on serial8250_isa_init_ports(), which discovers
the COM ports earlier using the addresses in SERIAL_PORT_DFNS.

These two patches remove the dependency on SERIAL_PORT_DFNS by
explicitly requesting the desired ttyS names.

-- 
