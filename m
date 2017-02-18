From: Maarten Brock <m.brock@vanmierlo.com>
Subject: Re: [PATCH] Tty: serial - Fix possible NULL derefrence.
Date: Sat, 18 Feb 2017 11:25:19 +0100
Message-ID: <c5f241d637c1c7208e95683eb50e7aa9@vanmierlo.com>
References: <CGME20170127111619epcas4p44c21059f85b7aa091016019c98d42939@epcas4p4.samsung.com>
 <1485515773-3542-1-git-send-email-shailendra.v@samsung.com>
 <20170130193743.GB27138@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170130193743.GB27138@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Shailendra Verma <shailendra.v@samsung.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.capricorn@gmail.com>, linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Greg,

Does that also mean that this isn't possible in the sc16is7xx.c driver 
in
sc16is7xx_spi_probe() line 1358 and sc16is7xx_i2c_probe() line 1419 ?

If so, should these checks be removed?

Kind regards,
Maarten

On 2017-01-30 20:37, Greg Kroah-Hartman wrote:
> On Fri, Jan 27, 2017 at 04:46:13PM +0530, Shailendra Verma wrote:
>> of_match_device could return NULL, and so can cause a NULL
>> pointer dereference later.
>> 
>> Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
>> ---
>>  drivers/tty/serial/max310x.c |    4 ++++
>>  1 file changed, 4 insertions(+)
>> 
>> diff --git a/drivers/tty/serial/max310x.c 
>> b/drivers/tty/serial/max310x.c
>> index 8a3e926..a94d147 100644
>> --- a/drivers/tty/serial/max310x.c
>> +++ b/drivers/tty/serial/max310x.c
>> @@ -1323,6 +1323,10 @@ static int max310x_spi_probe(struct spi_device 
>> *spi)
>>  	if (spi->dev.of_node) {
>>  		const struct of_device_id *of_id =
>>  			of_match_device(max310x_dt_ids, &spi->dev);
>> +		if (!of_id) {
>> +			dev_err(&spi->dev, "Error: No device match found\n");
>> +			return -ENODEV;
>> +		}
> 
> Patch now dropped as this isn't possible.
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
