From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH] serial/of-serial: Add 16654 chip to compatible string list
Date: Mon, 28 May 2012 20:17:58 +0200
Message-ID: <4FC3C156.5040609@antcom.de>
References: <1338199134-23885-1-git-send-email-stigge@antcom.de>
 <20120528100338.GI24149@n2100.arm.linux.org.uk> <4FC35F97.2030400@antcom.de>
 <20120528150311.GA28290@n2100.arm.linux.org.uk> <4FC3A768.3060208@antcom.de>
 <20120528163151.GB28290@n2100.arm.linux.org.uk> <4FC3BA89.4060804@antcom.de>
 <20120528180139.GC28290@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20120528180139.GC28290@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: srinivas.bakki@nxp.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kevin.wells@nxp.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org

On 28/05/12 20:01, Russell King - ARM Linux wrote:
>> Now, introducing a new type, can I add to 8250.c's uart_config[] by
>> introducing a new type (no. 22) after PORT_XR17D15X? Unfortunately,
>> there are the "ARM specific type numbers" after current PORT_MAX_8250
>> (21), but those are not listed in 8250.c's uart_config[]. Or how am I
>> supposed to add a new type?
> 
> If it's 8250, stick it in with the group, otherwise the array will
> become stupidly large.  That's why there's a separation of the two.

Do you mean adding one element to uart_config[] and increasing
PORT_MAX_8250 (actually, the size of uart_config[]) by one? I would also
need to increase the indices of all the following "ARM specific type
numbers" by one (the second group).

Or did I get sth. wrong here?

Thanks in advance,

Roland
