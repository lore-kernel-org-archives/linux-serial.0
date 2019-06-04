From: Erwan LE RAY <erwan.leray@st.com>
Subject: Re: Fwd: [PATCH] serial: stm32: fix a recursive locking in
 stm32_config_rs485
Date: Tue, 4 Jun 2019 13:55:42 +0000
Message-ID: <33271a7e-644b-70e3-f84c-d019b394ce77@st.com>
References: <20190604095452.6360-1-borut.seljak@t-2.net>
 <f2a264ac-e334-63b7-18c9-e45cde7bdf95@st.com>
 <41dddd5f-5c1c-3346-890a-8018f26ebd49@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <41dddd5f-5c1c-3346-890a-8018f26ebd49@st.com>
Content-Language: en-US
Content-ID: <D7564DEF725C3147AC98F2B3035C4186@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Borut Seljak <borut.seljak@t-2.net>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre TORGUE <alexandre.torgue@st.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org


> Hi Borut,
>
> Please add the following line in the commit message (before your =

> sign-off) in a V2 of your patch:
>
> fixes: 1bcda09d291081 ("serial: stm32: add support for RS485 hardware =

> control mode")
>
> I'm OK with the patch itself.
>
> Erwan.
>
>
> Subject: [PATCH] serial: stm32: fix a recursive locking in
>> stm32_config_rs485
>> Date: Tue,=A0 4 Jun 2019 11:54:51 +0200
>> From: Borut Seljak <borut.seljak@t-2.net>
>> CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
>> <alexandre.torgue@st.com>, Greg Kroah-Hartman
>> <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
>> borut.seljak@t-2.net, linux-serial@vger.kernel.org, Jiri Slaby
>> <jslaby@suse.com>, linux-stm32@st-md-mailman.stormreply.com,
>> linux-arm-kernel@lists.infradead.org
>>
>> Remove spin_lock_irqsave in stm32_config_rs485, it cause recursive =

>> locking.
>> Already locked in uart_set_rs485_config.
>>
>> Signed-off-by: Borut Seljak <borut.seljak@t-2.net>
>> ---
>> =A0 drivers/tty/serial/stm32-usart.c | 2 --
>> =A0 1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/tty/serial/stm32-usart.c
>> b/drivers/tty/serial/stm32-usart.c
>> index e8d7a7bb4339..da373a465f51 100644
>> --- a/drivers/tty/serial/stm32-usart.c
>> +++ b/drivers/tty/serial/stm32-usart.c
>> @@ -107,7 +107,6 @@ static int stm32_config_rs485(struct uart_port =

>> *port,
>> =A0=A0=A0=A0=A0 bool over8;
>> =A0=A0=A0=A0=A0 unsigned long flags;
>> =A0 -=A0=A0=A0 spin_lock_irqsave(&port->lock, flags);
>> =A0=A0=A0=A0=A0 stm32_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit)=
);
>> =A0=A0=A0=A0=A0=A0 port->rs485 =3D *rs485conf;
>> @@ -147,7 +146,6 @@ static int stm32_config_rs485(struct uart_port =

>> *port,
>> =A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0=A0 stm32_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_b=
it));
>> -=A0=A0=A0 spin_unlock_irqrestore(&port->lock, flags);
>> =A0=A0=A0=A0=A0=A0 return 0;
>> =A0 }
