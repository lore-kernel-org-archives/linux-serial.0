From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 2/5] tty: Introduce SER_RS485_SOFTWARE read-only flag
 for struct serial_rs485
Date: Thu, 12 Nov 2015 15:22:10 -0500
Message-ID: <5644F4F2.2080408@hurleysoftware.com>
References: <1447338836-8785-1-git-send-email-matwey@sai.msu.ru>
 <1447338836-8785-3-git-send-email-matwey@sai.msu.ru>
 <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20151112195707.5e9cb1d8@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/12/2015 02:57 PM, One Thousand Gnomes wrote:
> On Thu, 12 Nov 2015 17:33:53 +0300
> "Matwey V. Kornilov" <matwey@sai.msu.ru> wrote:
> 
>> This flag is supposed to be used by uart drivers using software rs485 direction control.
>>
>> Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
>> ---
>>  include/uapi/linux/serial.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
>> index 25331f9..95b15ca 100644
>> --- a/include/uapi/linux/serial.h
>> +++ b/include/uapi/linux/serial.h
>> @@ -121,6 +121,9 @@ struct serial_rs485 {
>>  #define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
>>  							   RTS pin after sent*/
>>  #define SER_RS485_RX_DURING_TX		(1 << 4)
>> +#define SER_RS485_SOFTWARE		(1 << 5)	/* Software
>> +							   implementation is
>> +							   being used */
> 
> I've only got one question here - why do we need this flag. Why does the
> application care whether the timer is in the kernel or in the chip. In
> particular think about cases where some combinations of features require
> software fallback and others don't. What would the flag indicate then.
> 
> The patches look nice but I'd strongly favour not having a software flag.
> It should never matter as the kernel API is the same in all cases and we
> should therefore discourage application code from trying to know things
> it doesn't need to worry about.

I specifically asked for it.

I can think of 2 reasons that userspace wants to know:
1. Because the characteristics of the software emulation are unacceptable so
   the application wants to terminate w/error rather than continue.
2. Because userspace will use different values for h/w vs. s/w. For example,
   right now, the emulation will raise/lower RTS prematurely when tx ends if
   the rts-after-send timer is 0.

I agree that combination features might be problematic.
An illustrative (kernel-space) example is the mess that is dmaengine_pause().
Some DMA implementations provide the means to stop and restart DMA without
losing data and some DMA implementations do not. Unfortunately, some
advertise they support dmaengine_pause() but only for lossy uses like audio.
Because the api hides this, the query interface for pause support is
useless.

Regards,
Peter Hurley
