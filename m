From: Martin Fuzzey <mfuzzey@gmail.com>
Subject: [PATCH  00/14] Serial : sc26xx - generalize and support SC2892
Date: Thu, 25 Feb 2010 14:34:50 +0100
Message-ID: <20100225133450.12331.94240.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:33916 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932526Ab0BYNe5 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 08:34:57 -0500
Received: by ey-out-2122.google.com with SMTP id 25so73164eya.19
        for <linux-serial@vger.kernel.org>; Thu, 25 Feb 2010 05:34:55 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, tsbogend@alpha.franken.de

This patch series generalizes the SC26xx driver to all embedded platforms
(in addition to the current SNI_RM) and adds support for the SC2892 DUART.

This chip is quite similar to the SC2692 but has more baud rates
and bigger FIFOs.

Changes since V1:
    Add patch: Use device name ttySC0 as per Documentation/devices.txt
    Add Acked-By: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
    Rename driver to sc2xxx

