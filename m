From: Amit Kucheria <akucheria@metricsystems.com>
Subject: persistent SLIP connections
Date: Thu, 17 Apr 2003 11:42:31 -0700
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <1050604951.1501.3.camel@amit.metricsystems.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mta8.algx.net ([67.92.168.237]:18227 "EHLO chimta03.algx.net")
	by vger.kernel.org with ESMTP id S261875AbTDQSao (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 17 Apr 2003 14:30:44 -0400
Received: from amit.metricsystems.com
 (ip67-89-211-170.z211-89-67.customer.algx.net [67.89.211.170])
 by chimmx03.algx.net
 (iPlanet Messaging Server 5.2 HotFix 1.10 (built Jan 23 2003))
 with ESMTP id <0HDI00ERZ3YJRF@chimmx03.algx.net> for
 linux-serial@vger.kernel.org; Thu, 17 Apr 2003 13:42:19 -0500 (CDT)
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>

Hi,

I currently use 'slattach' (actually a modified version) to setup a SLIP
connection between two machines. But when I unplug the cable and replug
it back in, I have to reconfigure the connection at both end.

Could this be handled in the slattach program, so that it does not
'hangup' due to loss of DCD or DSR?

Regards,
Amit

-- 
----------------------------------------------------------------------
Amit Kucheria          akucheria@NOSPAMmetricsystems.com
Metric Systems Corp.   2320 Cousteau Court, Suite 201, Vista, CA 92083
----------------------------------------------------------------------

