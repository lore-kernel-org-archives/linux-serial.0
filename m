From: Stanislav Kozina <skozina@redhat.com>
Subject: Re: [PATCH V2] [tty] Fix possible race in n_tty_read()
Date: Fri, 10 Aug 2012 12:52:20 +0200
Message-ID: <5024E7E4.4000409@redhat.com>
References: <4FE886C6.7090606@redhat.com> <20120626152159.2a34dcaf@pyramind.ukuu.org.uk> <50094C8E.5010308@redhat.com> <20120720161123.58fc9703@pyramind.ukuu.org.uk> <50221C30.20607@redhat.com> <20120808100019.6ca011a9@pyramind.ukuu.org.uk> <502256E8.5040300@redhat.com> <5022779F.8060309@redhat.com> <20120808162725.713e7a61@pyramind.ukuu.org.uk> <50239DFA.1090004@redhat.com> <20120809133557.7c9665e6@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35606 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606Ab2HJKwa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 10 Aug 2012 06:52:30 -0400
In-Reply-To: <20120809133557.7c9665e6@pyramind.ukuu.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Stanislaw Gruszka <sgruszka@redhat.com>


> Nor me - a WARN_ON and return would be better perhaps - it will at least
> then spew an error into the logs

Good idea, thanks. Patch sent.

-Stanislav
