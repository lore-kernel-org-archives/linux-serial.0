From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: linux-next: Tree for Nov 4 (serial console & earlycon)
Date: Wed, 4 Nov 2015 15:58:23 -0500
Message-ID: <563A716F.30607@hurleysoftware.com>
References: <20151104173800.39051ea8@canb.auug.org.au>
 <563A51E2.8060302@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <563A51E2.8060302@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 11/04/2015 01:43 PM, Randy Dunlap wrote:
> On 11/03/15 22:38, Stephen Rothwell wrote:
>> Hi all,
>>
>> Please do *not* add any material intended for v4.5 to your linux-next
>> included branches until after v4.4-rc1 has been released.
>>
>> Changes since 20151103:
>>
> 
> 
> on x86_64:
> 
> drivers/built-in.o: In function `setup_earlycon':
> (.init.text+0xe8d): undefined reference to `uart_parse_earlycon'
> 
> 
> CONFIG_SERIAL_CORE_CONSOLE is not enabled.
> CONFIG_CONSOLE_POLL is not enabled.
> 
> Full randconfig file is attached.

Hi Randy,

Thanks for the report.

Should be fixed by http://www.spinics.net/lists/linux-serial/msg19275.html
which isn't in Greg's tree yet.

Regards,
Peter Hurley
