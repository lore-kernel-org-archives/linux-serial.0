From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: more device files on same COM?
Date: Mon, 18 Aug 2003 10:55:52 -0400
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <006e01c36598$d1fe8aa0$294b82ce@stuartm>
References: <1061215398.16386.44.camel@dalibork.ultra.si>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from inetc.connecttech.com ([64.7.140.42]:51980 "EHLO
	inetc.connecttech.com") by vger.kernel.org with ESMTP
	id S271922AbTHROzu (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Aug 2003 10:55:50 -0400
In-Reply-To: <1061215398.16386.44.camel@dalibork.ultra.si>
List-Id: linux-serial@vger.kernel.org
To: 'Dalibor Kranjcic' <dalibor.kranjcic@ultra.si>, linux-serial@vger.kernel.org

From: linux-serial-owner@vger.kernel.org 
> I would like to use /dev/ttyS12 as virtual port for COM2, which would
> allow sending of additional data flow to COM2 independently from the
> data flow which is already sent trough /dev/ttyS1 (let's say ppp).

What's wrong with just opening ttyS1 again (twice)?

..Stu

