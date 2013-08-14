From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 5/5] ARM: davinci: serial: platform code cleanup
Date: Wed, 14 Aug 2013 11:27:09 +0000
Message-ID: <520B698D.60203@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
	<1371633342-1210-6-git-send-email-prakash.pm@ti.com>
	<51ED0534.2080408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51ED0534.2080408-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hs-ynQEQJNshbs@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Prakash,

On Monday 22 July 2013 10:11 AM, Sekhar Nori wrote:
> On Wednesday 19 June 2013 02:45 PM, Manjunathappa, Prakash wrote:
>> 1) "struct davinci_uart_config" is introduced to specify
>>    UART ports brought out or enabled on the board. But
>>    none of the boards use them for that purpose, so clean
>>    it up.
>> 2) Have pointer to platform device as a argument for
>>    davinci_serial_init(), no need of serial_dev in
>>    struct soc_info now.
>> 3) No need of davinci_serial_setup_clk(), not called from
>>    multiple places, hence reduce function call overhead.
> 
> 1) and 2) are related but 3) can be moved into a different patch - this
> patch will otherwise be doing too many things (hint for that is a vague
> headline and too many items to list in description)
> 
> Can you respin just this patch based on v3.12/soc branch of my tree?

Since I did not get a response to this and the window for v3.12 is
closing fast, I went ahead and did the split myself. Here is the result:

https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v3.12/soc

Thanks,
Sekhar
