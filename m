From: "y.k.oh" <y.k.oh@samsung.com>
Subject: Re: [PATCH] serial: samsung: macros with complex values should be
 enclosed in parentheses
Date: Thu, 22 Mar 2018 13:37:45 +0900
Message-ID: <2f2dcf3c-2432-3dc7-5fd4-f9326ef48455@samsung.com>
References: <CGME20180314021710epcas1p3766602fe312f87d916cab69af2acf203@epcas1p3.samsung.com>
        <1520993825-8605-1-git-send-email-y.k.oh@samsung.com>
        <20180314135804.GA21350@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180314135804.GA21350@kroah.com>
Content-language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 03/14/2018 10:58 PM, Greg KH wrote:
> On Wed, Mar 14, 2018 at 11:17:05AM +0900, YOUNGKEUN OH wrote:
>> Cleanup checkpatch error:
>> ERROR: Macros with complex values should be enclosed in parentheses
>>
>> Signed-off-by: YOUNGKEUN OH <y.k.oh@samsung.com>
>> ---
>>  drivers/tty/serial/samsung.c | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
>> index 3f2f8c1..da9bddb1 100644
>> --- a/drivers/tty/serial/samsung.c
>> +++ b/drivers/tty/serial/samsung.c
>> @@ -1455,7 +1455,7 @@ static int __init s3c24xx_serial_console_init(void)
>>  }
>>  console_initcall(s3c24xx_serial_console_init);
>>
>> -#define S3C24XX_SERIAL_CONSOLE &s3c24xx_serial_console
>> +#define S3C24XX_SERIAL_CONSOLE (&s3c24xx_serial_console)
> 
> That's not a complex macro!
> 
> Please use checkpatch as a hint, not the "truth".
> 
> thanks,
> 
> greg k-h
> 
Dear Greg.

Yes! Of course that's not a pretty complex macro. However, I think it is
important to make a small effort to modify the minimum standard,
Checkpatch ERROR, to ensure consistency in the Linux code.
Starting with this Checkpatch error of samsung.c, I would like to start
my efforts on contribution from a small point.  Please review it again.
If there are any points that require modification, such as comment,
then I'll modify it.
Thank you.

Best regards,
Youngkeun Oh
