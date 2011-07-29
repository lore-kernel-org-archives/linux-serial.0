From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Very strange data loss with jsm driver
Date: Fri, 29 Jul 2011 19:14:42 +0100
Message-ID: <20110729191442.35d09111@lxorguk.ukuu.org.uk>
References: <20110729160416.GK8562@caffeine.csclub.uwaterloo.ca>
	<20110729172736.4b199d31@lxorguk.ukuu.org.uk>
	<20110729165342.GB8566@caffeine.csclub.uwaterloo.ca>
	<20110729180650.GL8562@caffeine.csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110729180650.GL8562@caffeine.csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Breno Leitao <leitao@linux.vnet.ibm.com>
List-Id: linux-serial@vger.kernel.org

> I noticed fifosize in the uart_port info is set to 16, even though the
> fifo size is actually 64 bytes as all actual driver bits know.  What is
> fifosize actually used for?

Only within the driver. The generic code merely knows how it as a
configuration property but doesn't use it.

Alan
