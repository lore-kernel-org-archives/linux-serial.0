From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH] [PATCH] tty/serial: atmel: add new version check for usart
Date: Fri, 16 Feb 2018 10:27:50 +0100
Message-ID: <CACQ1gAjs1VwaVdnimDcyD9ZgxC6ei6oap-d9Fma14G9V6iw19g@mail.gmail.com>
References: <20180129113954.12011-1-jonas@orbital-systems.com>
 <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <e20ced24-666b-32b7-92cd-d30e1a10b42e@microchip.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Jonas Danielsson <jonas@orbital-systems.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

2018-02-05 13:36 GMT+01:00 Nicolas Ferre <nicolas.ferre@microchip.com>:
> On 29/01/2018 at 12:39, Jonas Danielsson wrote:
>> On our at91sam9260 based board the usart0 and usart1 ports report
>> their versions (ATMEL_US_VERSION) as 0x10302. This version is not
>> included in the current checks in the driver.
>>
>> Signed-off-by: Jonas Danielsson <jonas@orbital-systems.com>
>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>

Acked-by: Richard Genoud <richard.genoud@gmail.com>

> It must be the AT91SAM9260 rev. B SoC, isn't it?
>
> Thanks for your patch.
>
> Best regards,
>   Nicolas

Thanks !

Richard.
