From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/5] ARM: davinci: da850: do not specify clock_frequency
	for UART DT node
Date: Mon, 22 Jul 2013 15:33:13 +0530
Message-ID: <51ED0361.9020604@ti.com>
References: <1371633342-1210-1-git-send-email-prakash.pm@ti.com>
	<1371633342-1210-4-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1371633342-1210-4-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
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

On Wednesday 19 June 2013 02:45 PM, Manjunathappa, Prakash wrote:
> DT kernel on da850-evm comes up with garbled UART logs. This is because
> of mismatch in actual module clock rate and rate specified(clock-frequency)
> in DT blob. kernel should not assume or depend on bootloaders clock
> configuration, instead let it find the clock rate at runtime.
> 
> Issue discussed here before arriving on this implementation:
> "ARM: davinci: da850 evm: update clock rate for UART 1/2 DT nodes"
> https://patchwork.kernel.org/patch/2162271/
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>

Adding to v3.12/soc branch of my tree.

Thanks,
Sekhar
