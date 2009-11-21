From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [RFC PATCH  0/9] Serial : sc26xx - add SC2892 support
Date: Sat, 21 Nov 2009 14:39:51 +0100
Message-ID: <20091121133951.16090.74411.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:41031 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754610AbZKUNjs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 21 Nov 2009 08:39:48 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: tsbogend@alpha.franken.de, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

This patch series adds support for the SC2892 DUART.

This chip is quite similar to the SC2692 but has more baud rates
and bigger FIFOs.

The driver should probably be renamed (sc2xxx ??) but I haven't
done that yet to keep the patches readable.

I also intend to add support for the 28202 chip.

Unfortunately not having SC2692 hardware I haven't been able
to regression test this.


