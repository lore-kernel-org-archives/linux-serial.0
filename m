From: "Stuart MacDonald" <stuartm@connecttech.com>
Subject: RE: Serial custom speed deprecated?
Date: Fri, 25 Aug 2006 11:10:56 -0400
Message-ID: <043301c6c858$aa2de6d0$294b82ce@stuartm>
References: <m31wr6otlr.fsf@defiant.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422700AbWHYPLP@vger.kernel.org>
In-Reply-To: <m31wr6otlr.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: 'Krzysztof Halasa' <khc@pm.waw.pl>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Cc: 'David Woodhouse' <dwmw2@infradead.org>, linux-serial@vger.kernel.org, 'LKML' <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

From: On Behalf Of Krzysztof Halasa
> Not sure if we want int, uint, or long long for speed values :-)

Our max baud rate on any product is IIRC 1,8432,00. I checked with our
hardware guys, and they think the current theoretical upper limit is
around 30,000,000.

<words style="famous,last">
A uint ought to be enough for anybody.
</words>

..Stu
