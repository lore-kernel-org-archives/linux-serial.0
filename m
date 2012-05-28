From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: struct tty_flip_buffer replacement in newer kernels
Date: Mon, 28 May 2012 18:12:51 +0100
Message-ID: <20120528181251.7d5e6d9b@pyramind.ukuu.org.uk>
References: <CAMMxdh1Ak2LWeL=3qxTmvfR43E=wSHz5OmSj_irMubz0aK+TgA@mail.gmail.com>
	<4FBB8742.7050504@fastmail.fm>
	<20120522151033.33ef577a@pyramind.ukuu.org.uk>
	<1337697508.72614.YahooMailNeo@web44911.mail.sp1.yahoo.com>
	<20120522172700.02d7915d@pyramind.ukuu.org.uk>
	<1337855090.9672.YahooMailNeo@web44908.mail.sp1.yahoo.com>
	<1337855922.24203.YahooMailNeo@web44913.mail.sp1.yahoo.com>
	<20120524142219.6606e57a@pyramind.ukuu.org.uk>
	<1337871912.83081.YahooMailNeo@web44916.mail.sp1.yahoo.com>
	<20120524170025.6ca0407f@pyramind.ukuu.org.uk>
	<1338208815.57140.YahooMailNeo@web44914.mail.sp1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:34924 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751520Ab2E1RJw (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 28 May 2012 13:09:52 -0400
In-Reply-To: <1338208815.57140.YahooMailNeo@web44914.mail.sp1.yahoo.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dmitriy Alekseev <alexeev6@yahoo.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, =?utf-8?B?0K7RgNC40Lkg0JfQstC10YDQtdCy?= <yury.zverev@gmail.com>

On Mon, 28 May 2012 05:40:15 -0700 (PDT)
Dmitriy Alekseev <alexeev6@yahoo.com> wrote:

> Hi,
> 
> My st16c554 chip is connected with cpu (at91rm9200) in 68 (Motorola) mode, and formally works as 68c554.
> Is 8250 driver supports the 68 mode?
> I thought the driver maintains whole 16c554 IC, or it means only mode 16 is supported?

Not sure I understand the question
