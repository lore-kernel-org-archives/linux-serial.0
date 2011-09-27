From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] serial: SERIAL_MRST_MAX3110 should depend on X86_MRST
Date: Tue, 27 Sep 2011 12:01:15 +0100
Message-ID: <20110927120115.376b3c31@bob.linux.org.uk>
References: <201109162240.16874.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:40803 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843Ab1I0KxI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Sep 2011 06:53:08 -0400
In-Reply-To: <201109162240.16874.jdelvare@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-serial@vger.kernel.org

On Fri, 16 Sep 2011 22:40:16 +0200
Jean Delvare <jdelvare@suse.de> wrote:

> As I understand it, driver mrst_max3110 is only useful on Moorestown
> systems, so it should depend on X86_MRST.

Digging into this it builds fine on any X86 so it's more useful that it
is able to get build tested than to add extra config stuff making it
hard to catch bugs when changing the serial layer.
