From: "Matt Schulte" <matts@commtech-fastcom.com>
Subject: RE: development of serial driver (i.e. 8250_pci HOWTO)
Date: Tue, 5 Jul 2005 11:00:37 -0500
Message-ID: <MFEBKNPNJBEAJEICJEJNIEANCLAA.matts@commtech-fastcom.com>
References: <42C70CD5.1040808@cronyx.ru>
Reply-To: <matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp004.bizmail.sc5.yahoo.com ([66.163.175.81]:60066 "HELO
	smtp004.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261838AbVGEQAp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Jul 2005 12:00:45 -0400
Received: from localhost (localhost [127.0.0.1])
	by backup.commtech-fastcom.com (Postfix) with ESMTP id AABB6166345
	for <linux-serial@vger.kernel.org>; Tue,  5 Jul 2005 11:00:37 -0500 (CDT)
Received: from 66.136.244.89 ([127.0.0.1])
 by localhost (backup.commtech-fastcom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 15867-06 for <linux-serial@vger.kernel.org>;
 Tue,  5 Jul 2005 11:00:37 -0500 (CDT)
Received: from matt2k (unknown [192.168.1.7])
	by backup.commtech-fastcom.com (Postfix) with SMTP id 6A87D166344
	for <linux-serial@vger.kernel.org>; Tue,  5 Jul 2005 11:00:37 -0500 (CDT)
In-Reply-To: <42C70CD5.1040808@cronyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

> Roman Kurikin wrote:
> You may do like Cronyx did. This probably is not the best way in general,
> but if for device is enough a generic support and in case the driver is
> not a part of the system (e.q. need to support different kernel branches)
> this is I am sure the best way.

Roman, thank you for the suggestion.  While what you have done with your
driver is definitely a way of getting my card installed, I would still like
to see and example or a description of the "correct" way of going about this
with the new serial driver.

Matt Schulte
Commtech, Inc.
http://www.commtech-fastcom.com

