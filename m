From: =?iso-8859-1?q?suresh=20shenoy?= <msureshshenoy@yahoo.co.in>
Subject: Serial port.
Date: Tue, 3 Aug 2004 18:41:16 +0100 (BST)
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20040803174116.79915.qmail@web8207.mail.in.yahoo.com>
References: <20040724151137.GF18676@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from web8207.mail.in.yahoo.com ([203.199.70.76]:6739 "HELO
	web8207.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S266783AbUHCRyW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 3 Aug 2004 13:54:22 -0400
In-Reply-To: <20040724151137.GF18676@lug-owl.de>
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

  Thanks a lot to Benedict and Frank for suggestions.
The serial sniffer really made my day. I was able to
detect the problem to as handshake and write errors.
Basically the device was getting some garbage value
for some reason and hence was throwing away the data.
I fixed it and now the sniffer gives me 0 bytes
It worked for some commands i sent to the device. I am
just left with the checking of a motor. Then
everything is done.


Thanks a lot,
Suresh M Shenoy

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony
