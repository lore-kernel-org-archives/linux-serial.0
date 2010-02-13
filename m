From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH  00/12] Serial : sc26xx - generalize and support SC2892
Date: Sat, 13 Feb 2010 17:09:48 +0100
Message-ID: <20100213160948.22311.27542.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:34640 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033Ab0BMQJv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 13 Feb 2010 11:09:51 -0500
Received: by ey-out-2122.google.com with SMTP id d26so857228eyd.19
        for <linux-serial@vger.kernel.org>; Sat, 13 Feb 2010 08:09:50 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: tsbogend@alpha.franken.de

This patch series generalizes the SC26xx driver to all embedded platforms
(in addition to the current SNI_RM) and adds support for the SC2892 DUART.

This chip is quite similar to the SC2692 but has more baud rates
and bigger FIFOs.

The driver should probably be renamed (sc2xxx ??) but what about the device
name? Changing it could break existing userspace apps.

So for the moment I've left it as sc26xx.

Unfortunately not having SC2692 hardware I haven't been able
to regression test this.


