From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] serial: 8250: remove SERIAL_8250_AU1X00
Date: Fri, 23 Jul 2010 18:02:05 +0100
Message-ID: <20100723170205.GB3923@linux-mips.org>
References: <1279223105-23816-1-git-send-email-manuel.lauss@googlemail.com>
 <1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from h5.dl5rb.org.uk ([81.2.74.5]:37109 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760676Ab0GWRCL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Jul 2010 13:02:11 -0400
Content-Disposition: inline
In-Reply-To: <1279223105-23816-2-git-send-email-manuel.lauss@googlemail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Linux-serial <linux-serial@vger.kernel.org>

On Thu, Jul 15, 2010 at 09:45:05PM +0200, Manuel Lauss wrote:

Thanks, queued for 2.6.36.

It's probably harmless but there was a fairly large line offset in
arch/mips/alchemy/common/platform.c so you may want to check that what I
queued is ok.

  Ralf
