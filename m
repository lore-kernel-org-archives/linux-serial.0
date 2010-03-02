From: Sergei Organov <s.organov@javad.com>
Subject: Disregard: [PATCH] tty: Char: mxser, add support for CP114EL
Date: Wed, 03 Mar 2010 00:11:12 +0300
Message-ID: <87r5o24efj.fsf@osv.gnss.ru>
References: <87bpf6esd7.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from javad.com ([205.178.136.214]:42344 "EHLO 02aef2d.netsolvps.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588Ab0CBVLx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Mar 2010 16:11:53 -0500
In-Reply-To: <87bpf6esd7.fsf@osv.gnss.ru> (Sergei Organov's message of "Tue,
	02 Mar 2010 17:00:04 +0300")
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: linux-serial@vger.kernel.org

Sergei Organov <osv@javad.com> writes:
> Add support for MOXA:0x1144 pci device. It's a 4-port device and
> differs in no way from the others. So this turns out to be a trivial
> pci_device_id change.

Please disregard this patch for now. This board doesn't in fact work
properly with the driver and recognizing it by the driver might lead to
problems.

I'll be working on this, -- sorry for the noise.

-- Sergei.
