From: Richard Genoud <richard.genoud@gmail.com>
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
Date: Tue, 15 May 2018 15:14:47 +0200
Message-ID: <4d70c73e-9db7-bdff-7414-04a4843acae3@sorico.fr>
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
 <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
 <95a51c6c69bf1a2422f545ac1f06846ebcdb186a.camel@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <95a51c6c69bf1a2422f545ac1f06846ebcdb186a.camel@microchip.com>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org, gregkh@linuxfoundation.org, jslaby@suse.com, alexandre.belloni@bootlin.com, nicolas.ferre@microchip.com, broonie@kernel.org
List-Id: linux-serial@vger.kernel.org

On 15/05/2018 14:47, Radu Pirea wrote:
> On Mon, 2018-05-14 at 12:57 +0200, Richard Genoud wrote:
>> After your patch, the DMA is not selected anymore:
>> atmel_usart_serial atmel_usart_serial.0.auto: TX channel not
>> available, switch to pio
>> instead of:
>> atmel_usart fffff200.serial: using dma1chan2 for tx DMA transfers
>>
> Fixed.
>> And the kernel doesn't log anymore on the serial console, despite the
>> loglevel=8
>> (after reverting this series, the kernel logs reappears on the serial
>> console)
>>
> Which serial are you using as console? 
fffff200.serial (sam9g35-cm)
( stdout-path = "serial0:115200n8"; in the DTS )

With this series applied, all the kernel log goes on the screen.
Without, it goes on the serial debug.

>> (tests done on sam9g35)
>>
> I will consider the rest of suggestions. 
>> regards,
>> Richard
