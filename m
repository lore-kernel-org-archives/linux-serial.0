From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/3] x86, boot: add mmio serial during compressed boot
Date: Fri, 12 Jul 2013 13:20:13 -0700
Message-ID: <b37c0f48-36b1-41c8-a8b1-b313009e4cdd@email.android.com>
References: <1373659660-31123-1-git-send-email-keescook@chromium.org> <CAGXu5jL=oSkWTGEbYLxAU1PwGbgoyeiOgFV31Gd4yj1JkDECBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jL=oSkWTGEbYLxAU1PwGbgoyeiOgFV31Gd4yj1JkDECBg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Landley <rob@landley.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Can you fix & resend the patch?

Kees Cook <keescook@chromium.org> wrote:

>On Fri, Jul 12, 2013 at 1:07 PM, Kees Cook <keescook@chromium.org>
>wrote:
>
>> Allows "console=uart[8250],mmio[32],0xADDR[,BAUDn8[,BASE_BAUD]]" to
>> be recognized during compressed boot early console setup, and during
>> boot console setup. Replaces defines with common serial defines. Adds
>> suport for mmio-based serial devices to compressed-boot early
>console,
>> and plumbs support for defining the base baud rate for UART clock
>> calculations (since mmio serial cards may not have the standard rate,
>> resulting in incorrect baud rates for mmio devices).
>>
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>> ---
>> diff --git a/include/uapi/linux/serial_reg.h
>> b/include/uapi/linux/serial_reg.h
>> index e632260..bdeaf5a 100644
>> --- a/include/uapi/linux/serial_reg.h
>> +++ b/include/uapi/linux/serial_reg.h
>> @@ -333,12 +333,13 @@
>>
>>  #define UART_RSA_TCR_SWITCH (1 << 0) /* Timer on */
>>
>> +#define SERIAL_BAUD_BASE (1843200/16)
>>  /*
>>   * The RSA DSV/II board has two fixed clock frequencies.  One is the
>>   * standard rate, and the other is 8 times faster.
>>   */
>> -#define SERIAL_RSA_BAUD_BASE (921600)
>> -#define SERIAL_RSA_BAUD_BASE_LO (SERIAL_RSA_BAUD_BASE / 8)
>> +#define SERIAL_RSA_BAUD_BASE_LO SERIAL_BAUD_BASE
>> +#define SERIAL_RSA_BAUD_BASE (SERIAL_RSA_BAUD_BASE * 8)
>>
>
>Argh, just found this typo during an allyesconfig build. Above should
>be:
>
>#define SERIAL_RSA_BAUD_BASE (SERIAL_BAUD_BASE * 8)
>
>-Kees

-- 
Sent from my mobile phone. Please excuse brevity and lack of formatting.
