From: "Matt Schulte" <matts@commtech-fastcom.com>
Subject: development of serial driver
Date: Wed, 29 Jun 2005 12:01:46 -0500
Message-ID: <MFEBKNPNJBEAJEICJEJNMEPMCKAA.matts@commtech-fastcom.com>
Reply-To: <matts@commtech-fastcom.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp004.bizmail.sc5.yahoo.com ([66.163.175.81]:11961 "HELO
	smtp004.bizmail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262609AbVF2RBr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 29 Jun 2005 13:01:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by backup.commtech-fastcom.com (Postfix) with ESMTP id 5B704166345
	for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2005 12:01:46 -0500 (CDT)
Received: from 66.136.244.89 ([127.0.0.1])
 by localhost (backup.commtech-fastcom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 04593-04 for <linux-serial@vger.kernel.org>;
 Wed, 29 Jun 2005 12:01:46 -0500 (CDT)
Received: from matt2k (unknown [192.168.1.7])
	by backup.commtech-fastcom.com (Postfix) with SMTP id 27337166344
	for <linux-serial@vger.kernel.org>; Wed, 29 Jun 2005 12:01:46 -0500 (CDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

I am a developer for a line of multiport PCI serial cards.  I have received
enough requests that it is time to make the cards work with the 2.6.x
kernels.  I see that serial.c has been deprecated and I am wondering if
anyone can tell me exactly how the serial is supposed to work in the new
kernel?

How can I modify the existing stock driver to include my card as well?  Is
there a CVS version somewhere that I could checkout?  Do I send patches
somewhere?

Does anyone even read this list anymore?

Thank you,

Matt Schulte
Commtech, Inc.
Voice: 316-636-1131
Fax: 316-636-1163
http://www.commtech-fastcom.com

