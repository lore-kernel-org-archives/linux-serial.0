From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] Remove UPIO_DWAPB{,32} from 8250 driver
Date: Tue, 16 Aug 2011 16:39:31 +0200
Message-ID: <201108161639.32166.arnd@arndb.de>
References: <1313399875-11006-1-git-send-email-jamie@jamieiles.com> <201108161605.08811.arnd@arndb.de> <20110816142026.GH2786@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56898 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab1HPOje (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 16 Aug 2011 10:39:34 -0400
In-Reply-To: <20110816142026.GH2786@pulham.picochip.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jamie Iles <jamie@jamieiles.com>
Cc: linux-serial@vger.kernel.org

On Tuesday 16 August 2011, Jamie Iles wrote:
> In that case I could add an ns8250dw compatible string and put the 
> handlers into here (both 8 and 32 bit variants).

Not sure I understand what the effect of that is. I'll just wait
for your patch then and assume that you're doing it right.

> Note that the MIPS 
> user that I've removed in this series should probably still keep the 
> accessors in the platform code as they've remapped the USR to a 
> different location to the Synopsys spec.

Agreed.

	Arnd
