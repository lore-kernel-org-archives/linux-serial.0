From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [RFC PATCH] tty/serial: RS485 bindings for device tree
Date: Wed, 12 Oct 2011 14:02:38 +0200
Message-ID: <4E9581DE.20702@atmel.com>
References: <1318353208-24422-1-git-send-email-nicolas.ferre@atmel.com>
	<4E947CA6.9010703@atmel.com> <3289709.mzRgbAUyPT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <3289709.mzRgbAUyPT@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: jesper.nilsson@axis.com, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, claudio@evidence.eu.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk
List-Id: linux-serial@vger.kernel.org

On 10/11/2011 08:41 PM, Arnd Bergmann :
> On Tuesday 11 October 2011 19:28:06 Nicolas Ferre wrote:
>>
>>> +Optional properties:
>>> +- linux,rs485-enabled-at-boot-time: empty property telling to enable the rs485
>>> +  feature at boot time. It can be disabled later with proper ioctl.
>>
>> +- linux,rs485-rx-during-tx: empty property that enable the receiving of data
>> +  even whilst sending data.
> 
> This does not sound too linux specific. If it's a hardware property, don't
> use the 'linux,' prefix and just make it 'rs484-full-duplex' or such.

Ok, I understand. Your remark may also apply to linux,rs485-rts-delay.
So we may end-up with:

- linux,rs485-enabled-at-boot-time
- rs485-rx-during-tx
- rs485-rts-delay

Best regards,
-- 
Nicolas Ferre
