From: Michael Anderson <mjanders@us.ibm.com>
Subject: Re: [PATCH] linux-2.6.2-rc3 Add icom serial device driver
Date: Tue, 9 Mar 2004 08:43:43 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <OFBFE36237.BC6FEFD8-ON86256E52.00508488-86256E52.0050F852@us.ibm.com>
References: <20040221230233.C18248@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from e5.ny.us.ibm.com ([32.97.182.105]:9149 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261959AbUCIOoQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 9 Mar 2004 09:44:16 -0500
In-Reply-To: <20040221230233.C18248@flint.arm.linux.org.uk>
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-serial@vger.kernel.org


An updated icom patch will be found at:

http://www-124.ibm.com/linux/patches/misc/icom-2.6.4-rc2.patch

This includes the rework which removes the firmware images from the icom.h
and uses the request_firmware interface to load the firmware images during
startup time.

