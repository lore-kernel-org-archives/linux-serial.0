From: Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v3] tty: serial: meson: allow baud-rates lower than 9600
Date: Sat, 04 Nov 2017 17:44:50 +0100
Message-ID: <59FDEE82.4040204@baylibre.com>
References: <19343ad6-75de-4059-825a-98ed40ecf423@myway.de> <20171104131352.GA9271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171104131352.GA9271@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, V10lator <v10lator@myway.de>
Cc: Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org


Le 04/11/2017 14:13, Greg Kroah-Hartman a écrit :
> On Sat, Nov 04, 2017 at 02:00:00PM +0100, V10lator wrote:
>> Devices like DCF77 receivers need the baud-rate to be as low as 50.
>>
>> I have tested this on a Meson GXL device with uart_A.
>>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jslaby@suse.com>
>> Cc: Carlo Caione <carlo@caione.org>
>> Cc: Kevin Hilman <khilman@baylibre.com>
>> Cc: linux-amlogic@lists.infradead.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Thomas Rohloff <v10lator@myway.de>
>> ---
>> drivers/tty/serial/meson_uart.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> What changed from v2?
> 
> And I need a real name as the author of the patch :(
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 

Hi Thomas,

Make sure the "From" header of your mail matches the Signed-off-by tag, overwise use the --from option with "git send-email" to be sure, or generate the patch with the "git format-patch" with the "--from" option.

Anyway :
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
