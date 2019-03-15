From: maowenan <maowenan@huawei.com>
Subject: Re: [PATCH serial v3] sc16is7xx: missing unregister/delete driver on
 error in sc16is7xx_init()
Date: Fri, 15 Mar 2019 21:56:07 +0800
Message-ID: <566a03ba-aae9-3169-5db3-3417d5eb60f9@huawei.com>
References: <20190311093959.86344-1-maowenan@huawei.com>
 <20190311121918.GD2412@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311121918.GD2412@kadam>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, vz@mleia.com
List-Id: linux-serial@vger.kernel.org

ping...

On 2019/3/11 20:19, Dan Carpenter wrote:
> On Mon, Mar 11, 2019 at 05:39:59PM +0800, Mao Wenan wrote:
>> Add the missing uart_unregister_driver() and i2c_del_driver() before
>> return from sc16is7xx_init() in the error handling case.
>>
>> Signed-off-by: Mao Wenan <maowenan@huawei.com>
>> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> 
> This looks nice.  Thanks!
> 
> Reviewed-by: Dan Carpeter <dan.carpenter@oracle.com>
> 
> regards,
> dan carpenter
> 
> 
> 
