From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v2 2/2] Introduce 8250_men_mcb
Date: Fri, 11 Aug 2017 15:13:21 +0200
Message-ID: <20170811131321.GA11543@linux-x5ow.site>
References: <20170802075853.18911-1-michael.moese@men.de>
 <20170802075853.18911-2-michael.moese@men.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170802075853.18911-2-michael.moese@men.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Michael Moese <michael.moese@men.de>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, johannes.thumshirn@suse.de
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 02, 2017 at 09:58:53AM +0200, Michael Moese wrote:
> This patch introduces the 8250_men_mcb driver for the MEN 16Z125
> IP-Core. This is a 16550-type UART with a 60 byte FIFO.
> Due to strange old hardware, every board using this IP core requires
> different values for uartclk. A reasonable default is included in
> addition to the support of three boards. Additional values for other
> boards will be added later.
> 
> This v2 has some whitespace fixes, I screwed this up yesterday.

Nit: this should go below the '---' marker.

Apart from that,
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
