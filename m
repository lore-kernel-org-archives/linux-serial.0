From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH] serial: samsung: Reorder the sequence of clock control
 when call s3c24xx_serial_set_termios()
Date: Fri, 25 Mar 2016 17:22:31 +0900
Message-ID: <56F4F547.4000706@samsung.com>
References: <1457916065-27418-1-git-send-email-cw00.choi@samsung.com>
 <56F481E8.1000602@samsung.com> <56F4F357.2060407@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <56F4F357.2060407@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>, gregkh@linuxfoundation.org, jslaby@suse.com
Cc: k.kozlowski@samsung.com, kgene@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, "Robert Baldyga (SRPOL)" <r.baldyga@samsung.com>
List-Id: linux-serial@vger.kernel.org

Dear Marek,

On 2016=EB=85=84 03=EC=9B=94 25=EC=9D=BC 17:14, Marek Szyprowski wrote:
> Dear Chanwoo,
>=20
> On 2016-03-25 01:10, Chanwoo Choi wrote:
>> Hi Robert,
>>
>> I send following patch to fix the broken serial log of Exynos SoC.
>> As I knew, you also knew this issue.
>> If possible, could you review or test this patch?
>=20
> Robert no longer works for Samsung, so I'm afraid that he won't be ab=
le to test
> this patch.

Ah. Thanks for your reply.

>=20
>> Best Regards,
>> Chanwoo Choi
>>
>> On 2016=EB=85=84 03=EC=9B=94 14=EC=9D=BC 09:41, Chanwoo Choi wrote:
>>> This patch fixes the broken serial log when changing the clock sour=
ce
>>> of uart device. Before disabling the original clock source, this pa=
tch
>>> enables the new clock source to protect the clock off state for a s=
plit second.
>>>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>   drivers/tty/serial/samsung.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/sams=
ung.c
>>> index d72cd736bdc6..80d59dbfebba 100644
>>> --- a/drivers/tty/serial/samsung.c
>>> +++ b/drivers/tty/serial/samsung.c
>>> @@ -1265,13 +1265,13 @@ static void s3c24xx_serial_set_termios(stru=
ct uart_port *port,
>>>       if (ourport->baudclk !=3D clk) {
>>>           s3c24xx_serial_setsource(port, clk_sel);
>>>   +        clk_prepare_enable(clk);
>>> +
>=20
> IMHO clk_prepare_enable() should be moved before s3c24xx_serial_setso=
urce() to be
> really sure that there will be no period of hw operating with disable=
d baud clock.
> Could you check if it works for you?

Yes. I tested it without any problem.
But, as you commented, clk_prepare_enable() should be called before s3c=
24xx_serial_setsource().

I'll modify it.

>=20
>>>           if (!IS_ERR(ourport->baudclk)) {
>>>               clk_disable_unprepare(ourport->baudclk);
>>>               ourport->baudclk =3D ERR_PTR(-EINVAL);
>>>           }
>>>   -        clk_prepare_enable(clk);
>>> -
>>>           ourport->baudclk =3D clk;
>>>           ourport->baudclk_rate =3D clk ? clk_get_rate(clk) : 0;
>>>       }
>=20
> Best regards

Best Regards,
Chanwoo Choi
