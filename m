From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] tty: serial: uartlite: Support uartlite on big and little endian systems
Date: Mon, 11 Feb 2013 20:18:35 +0000
Message-ID: <201302112018.35706.arnd@arndb.de>
References: <1360605874-18310-1-git-send-email-michal.simek@xilinx.com> <1360605874-18310-2-git-send-email-michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:49937 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759936Ab3BKUSx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 15:18:53 -0500
In-Reply-To: <1360605874-18310-2-git-send-email-michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michal Simek <michal.simek@xilinx.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, monstr@monstr.eu, Peter Korsgaard <jacmet@sunsite.dk>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-kernel@vger.kernel.org

On Monday 11 February 2013, Michal Simek wrote:
> 
> Use big and little endian accessors function to reflect system configuration.
> Detection is done via control register in ulite_request_port.
> 
> Tested on Microblaze LE, BE, PPC440 and Arm zynq.
> 
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
