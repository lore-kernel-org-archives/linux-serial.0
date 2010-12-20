From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: Re: Fw: about sc16is7x2 drivier
Date: Mon, 20 Dec 2010 10:09:32 +0100
Message-ID: <4D0F1D4C.4010600@iis.fraunhofer.de>
References: <4D0F1B6A.0A69AA.31769@m50-133.163.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060601030509030805050100"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from relay03-haj2.antispameurope.com ([83.246.65.53]:48701 "EHLO
	relay03-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754435Ab0LTJJo (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Dec 2010 04:09:44 -0500
In-Reply-To: <4D0F1B6A.0A69AA.31769@m50-133.163.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: changgx <changgx@163.com>
Cc: "hunterzhu@baite-group.com" <hunterzhu@baite-group.com>, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------060601030509030805050100
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 8bit

Hello Kathy Chang,

thank you for your effort. Can you provide a patch for the sc16is7x2.c file?

Regards,
Manuel Stahl

On 20.12.2010 10:01, changgx wrote:
> hello,Manuel Stahl:
> 
> Sc16is7x2 driver has been successfully debugged.
> 
> In sc16is7x2.c，the control to the var .cs_change does not match with at91sam9260 driver.
> 
> 1、
> In function sc16is7x2_startup(),the spi chip select maintains low level after the setence cmds = sc16is7x2_alloc_spi_cmds(8).
> It caused a error about next SPI operation.
> 
> Improved method is to use 8 sc16is7x2_write_async() function to set sc16is7x2 reg.
> 
> 2、
> 
> In sc16is7x2_msg_add_fifo_tx() function， you need to take anti-cs_change variables.
> 
> 
> good luck!!!
> 
> 
> ======= 2010-12-14 11:52:00 您在来信中写道：=======
> 
>> Hello again,
>>
>> The commands in sc16is7x2_spi_async are sent async (as the name says),
>> so the first time you execute sc16is7x2_read(ts->spi, UART_IER,ch) the
>> async part was not yet completed, the second time it was completed and
>> has set UART_IER to 0.
>>
>> Regards,
>> Manuel
>>
>> On 13.12.2010 06:43, changgx wrote:
>>>      hello，manuel.stahl：
>>>
>>>      excuse me!!
>>>
>>>      I found the sc16is7x2.c driver provided by you on the internet the
>>>      other day. And I explante it to my board.
>>>
>>>      My develop environment is about ：CPU for AT91SAM9260 and kennel for
>>>      linux-2.6.27.
>>>
>>>      But I found some questions in debugging.
>>>
>>>      In the function of sc16is7x2_startup( ), i add the sentence to read
>>>      register value after sc16is7x2_spi_async(ts->spi, cmds, 8) sentence
>>>      and i find that the return value is always 0xff.
>>>
>>>      for example:
>>>
>>>      int uier1,uier2;
>>>
>>>      uier1 = sc16is7x2_read(ts->spi, UART_IER,ch);
>>>      SC16_PRINTK("+++++++++++++++++++++>  s ：d UART_IER = x
>>>      \n",__func__,__LINE__,uier1);
>>>      uier2 = sc16is7x2_read(ts->spi, UART_IER,ch);
>>>      SC16_PRINTK("+++++++++++++++++++++>  s ：d UART_IER = x
>>>      \n",__func__,__LINE__,uier2);
>>>
>>>      the print result:
>>>
>>>      +++++++++++++++++++++>  sc16is7x2_startup : 512 UART_IER = ff
>>>      +++++++++++++++++++++>  sc16is7x2_startup : 515 UART_IER = 0
>>>
>>>      The results is that the first time is 0xff, the secend is 0.
>>>
>>>      And it is same to read other register.
>>>
>>>      please give me some advice for this question.
>>>
>>>      ps: thank you very much for your open souce and look forward to your
>>>      email.
>>>
>>>      thanks！
>>>
>>>      kathy chang
>>>
>>>      2010-12-13
>>>
>>>      ------------------------------------------------
>>>
>>>      Email：changgx@163.com<mailto:changgx@163.com>
>>>
>>>      ------------------------------------------------
>>>
>>>
>>>
>>> = = = = = = = = = = = = = = = = = = = =
>>> 　　　　　　　　致
>>> 礼！
>>> changgx
>>> changgx@163.com<mailto:changgx@163.com>
>>> 2010-12-13
>>> 　　　　　　　　　　　　　　
>>
>>
>> -- 
>> Manuel Stahl
>> Fraunhofer-Institut IIS
>> Leistungsoptimierte Systeme
>>
>> Nordostpark 93
>> D90411 Nürnberg
>> Telefon  +49 (0)911/58061-6419
>> Fax      +49 (0)911/58061-6398
>> E-Mail   manuel.stahl@iis.fraunhofer.de
>>
>> http://www.iis.fraunhofer.de
>> http://www.smart-power.fraunhofer.de
>>
>>
>>
>> __________ Information from ESET Smart Security, version of virus signature database 5563 (20101026) __________
>>
>> The message was checked by ESET Smart Security.
>>
>> http://www.eset.com
> 
> = = = = = = = = = = = = = = = = = = = =
> 			
> 
> 　　　　　　　　致
> 礼！
> 
> 				
> 　　　　　　　　changgx
> 　　　　　　　　changgx@163.com
> 　　　　　　　　　　2010-12-20
> 
> 
> 
> 


-- 
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 Nürnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de

--------------060601030509030805050100
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"

YmVnaW46dmNhcmQNCmZuOk1hbnVlbCBTdGFobA0KbjpTdGFobDtNYW51ZWwNCmVtYWlsO2lu
dGVybmV0Om1hbnVlbC5zdGFobEBpaXMuZnJhdW5ob2Zlci5kZQ0KdGVsO3dvcms6KzQ5IDkx
MSA1ODA2MS02NDE5DQp4LW1vemlsbGEtaHRtbDpGQUxTRQ0KdmVyc2lvbjoyLjENCmVuZDp2
Y2FyZA0KDQo=
--------------060601030509030805050100--
