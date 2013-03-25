From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/3] serial: of_serial: Handle hw-flow-control property
Date: Mon, 25 Mar 2013 11:40:31 +0000
Message-ID: <201303251140.31866.arnd@arndb.de>
References: <1364211286-31611-1-git-send-email-heikki.krogerus@linux.intel.com> <1364211286-31611-4-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54960 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756383Ab3CYLkf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 25 Mar 2013 07:40:35 -0400
In-Reply-To: <1364211286-31611-4-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ley Foon Tan <lftan@altera.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Monday 25 March 2013, Heikki Krogerus wrote:
> This will add support for hardware flow control. It is
> limited to be used only with 8250 driver.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Does this imply that we can use hardware flow control only when this
flag is set in the device tree? I assumed that working flow control
would be the default. Is it not?

	Arnd
