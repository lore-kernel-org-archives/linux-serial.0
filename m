From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ARM: davinci: serial: platform code cleanup
Date: Thu, 6 Jun 2013 15:55:43 +0530
Message-ID: <51B063A7.8020907@ti.com>
References: <1369729686-6595-1-git-send-email-prakash.pm@ti.com>
	<1369729686-6595-6-git-send-email-prakash.pm@ti.com>
	<51AF2400.3020906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51AF2400.3020906-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On 6/5/2013 5:11 PM, Sekhar Nori wrote:
> 
> On 5/28/2013 1:58 PM, Manjunathappa, Prakash wrote:
>> 1) "struct davinci_uart_config" is introduced to specify
>>    UART ports brought out or enabled on the board. But
>>    none of the boards use them for that purpose, so clean
>>    it up.
>> 2) Have pointer to platform device as a argument for
>>    davinci_serial_init(), no need of serial_dev in
>>    struct soc_info now.
>> 3) No need of davinci_serial_setup_clk(), not called from
>>    multiple places, hence reduce function call overhead.
>>
>> Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
>> Suggested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
> 
> We generally clean up code before undertaking modifications. Is there a
> reason why this cannot be done first-up?

Never mind this question. I figured it out myself. You need to have the
serial clock setup removed from DT before you can do any reasonable
clean-up and that happens only with 4/5.

Thanks,
Sekhar
