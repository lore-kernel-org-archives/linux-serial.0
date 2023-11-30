Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gZs1JbDT"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4D4B5;
	Thu, 30 Nov 2023 06:36:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZtCiKUtP/yXkP6XaT01v+xmH6qBW8HyarbFqTunBa5G3Oyenz5GINeiBLcLpAvjAI2A+Wj+mj/iOeNwSk46xJnrSaVFWDB3blasD575xMZ44DPb9q6+O/WmEX45wDpzrV7w3RF+ORlbdVlr+BNJsPyMp6qQh1BRfcgxQr3tiEU/crlP7y+YxEzRbUqgoju7rgzTUgyEM4UPqfKyApr2q9O8XlEitWFJSRB6RPLA4muxsb6z+5Q1mAd3HelJ0bM/qkiWjPIs9hMT8FrODzuvBeqhe/wPWqa5zduwC9S37TC4Rc62RMbvyPtmYNeLK77sEPAMNV99/wywT9zlMhqnLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cu5HLvkOkcw9BUcdAqYiciHdIFzQ0kW8ZYbrW9cXomY=;
 b=ha0EyORS490WyQXuYOaX6eYz/Lqhly6V78u5dmgkmR6Rr+cmPoZO3SfaN4IE66vg/8h3H1N0foJOZrfLYS0eu0MNkbFXeOECE+OQgGHyOv4wot3knEErFt7VnuH/myZddMhdkr4Sc2lFeuVPZjzRJPmtEDEJwcuRfWzm4iJqoMU2yHVAGuFYI1PeDqz7jKLnxhDMloxaLmqgujfJe5a9pEH4El3TPlClU26SXYQ2L0Fj0QbKT3qN04Pdxa42gFGBftzyUr9mnNgta5zZJHm4cljrPcc4bo1GnMjalJbv0QGxATGMWAMrBYhS3L3JZT0I4b9MNCAfAYq9hFIFPacvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cu5HLvkOkcw9BUcdAqYiciHdIFzQ0kW8ZYbrW9cXomY=;
 b=gZs1JbDTZyHblSSZJ7tc3bGApUv70o/Cz+6WVEsigERZ7qcfz04wP/MCnAxps9twsaZ3AZNZ+uS6dGj3Q4IXoXt4AbJvDBGPmgOiA1YlKFFTWSYqoT65FkUq1qpzBpPPr+UPocVdsemyt9Menbdmm3/9c1fyLS3CO50HDz71YH8Pk03Gskapc08DmMJ41BcLd2UhSZNisTuaNjwz1Z9EBkMLo5ayZP1h++9lCoFwUHgL1VfaIylAbAVY1pIQhY59u2IanNEKgasj/aSMu0iR7nS3wzKd4ydmoLxpcUda0zd/PwvaSyxFhn639JmEW/D0ev9gN3zTLJJRzA32J9tpSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com (2603:10a6:208:16c::20)
 by VE1PR04MB7408.eurprd04.prod.outlook.com (2603:10a6:800:1b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 14:36:25 +0000
Received: from AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6]) by AM0PR04MB6467.eurprd04.prod.outlook.com
 ([fe80::5c46:ada1:fcf3:68e6%7]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 14:36:25 +0000
Message-ID: <0dd783e9-1cd2-467f-a90d-e63fec88350c@suse.com>
Date: Thu, 30 Nov 2023 15:36:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: question on correct error return from break_ctl()
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oliver Neukum <oneukum@suse.com>
Cc: Johan Hovold <johan@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 USB list <linux-usb@vger.kernel.org>, linux-serial@vger.kernel.org
References: <7e649033-0e1d-4c21-a1f3-ceb2de894861@suse.com>
 <2023113055-molecular-backlands-6b3d@gregkh>
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <2023113055-molecular-backlands-6b3d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To AM0PR04MB6467.eurprd04.prod.outlook.com
 (2603:10a6:208:16c::20)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6467:EE_|VE1PR04MB7408:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4dd367-e15b-4118-3694-08dbf1b1bae2
X-LD-Processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtFwd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qFLcgjyh/dmSUyWxv7YFJls40kCUco9FZtYOpv3JQBAxI4y2bYbhAhanfVehIBmg1Qqbtew5V+w0wVORAFi9OZ2tkhymMP7zgOW14+RU+VYxDwr0tCh5hKe+wDUlKiAucjk5QpjWC5sKiVVIClswh3REytBaSEnoMQRtnXtv9ARDkG7W/kMYIVCvVocvHUbykzAUyvWmQ6iQR8VJl8DRHLj1JMuO4460+7e9wLcNkk+V1AFlDTeOoinua9Aafdyp4tGAz3/a2lztZ8Hy3WoW3vQBbd/nLBeIJk/ruQ6Ax4O4JEuiayh1b3O2VlhiYeKE+EJaNGabXV01EN8Gl6VuZz63gm/K8zQ6/a65wGDyF98HS8O3ozeHVEfwvmcfuK7S+MX1O6kyAyh8HjdEAkBxNafZgYQ56qokmnkRt0WKDZghT/XHgRvvezURP+Z6i9X+e6I+hcM1AaZh9EtlvO2pmDZnQluooaVLWCHMMTjzMftcDAXu5sL8AUuyM44B74WCGbVd0edBsFtHOKviR/Eunay+/RqhhWruR+ULouKX1LAO7usW+kgwIwkX10GtfifSGsT9FwAOdUAIfptNWjfF3lhK6iPwP7kJJU1iSdY46W0ePgAMja8aCeFsdYY5Qx7H7sH+m+Zj9iyCGPiqXbc3TQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6467.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(41300700001)(54906003)(66556008)(316002)(66946007)(110136005)(36756003)(8936002)(66476007)(4326008)(8676002)(6486002)(86362001)(2906002)(31696002)(5660300002)(478600001)(4744005)(6506007)(6666004)(6512007)(83380400001)(2616005)(38100700002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJNWDRPNHRhUktraDlrOFFWRDR6RlErNCtXbWZqaXFOdkwwOW1hNjJ6c1hX?=
 =?utf-8?B?VWNZbnh6cGhNZXFxWGkyVDhIWUdnYTFZQkVSb2EwbTV2NXZyQnl4cnp6eFpJ?=
 =?utf-8?B?MWhrMDlKbTR6UnBtNC95ZXpjMWhCRmtwUStKZ1h0NHRLNTlmbS9DNStOb0Iy?=
 =?utf-8?B?bzdGMTF2WFRBN2pSUnZCNUdtMXkrb3FRUERJdmlTSlR3SFB1MEVtbXJ2VUJJ?=
 =?utf-8?B?SEMxblVLc0ZSdURiWlBBc3IyYTRtVTdoQW9FTG0xOHk5ajhOVyswbW8yNDhL?=
 =?utf-8?B?Rk9naTI2MG5ObUtrWUxHWi9qRGJrbWFrSGVlY3J6eTI1RlNSWVd2ZFlSQVAy?=
 =?utf-8?B?S1BObXp4TUtVaVZaY2tTakxNYWlhNjZ4SmFSNktYdTQ4L2IrYXJid0s4QXMy?=
 =?utf-8?B?cFlVa21tUkYxWmhYZkNNdEV0Y1FUalMramxHaFlja01ncm04b1U3cG1EQklh?=
 =?utf-8?B?ODBtUEJOUjg2cmdmZ25mTGtLd3MxbXRacU4xNzJoUFBtMi9mSXNoNzZXWGtm?=
 =?utf-8?B?MEttOENHb29lcEtXWjh4bGxBVkRKOWJwcmM4cWhKdFFocVpEMWo1SjFCY2FP?=
 =?utf-8?B?Vzg1SS96VG94U2RuaXFpaWx4L24xR2RZRW5MZC9vMUJ3bnJKZGloRGEzNUx1?=
 =?utf-8?B?bzZIaTROS3ZGeDE3S1Vhc2hBTFB2YTB3RndsVnRpdFVmUzFzLzZJQ3FnTS9a?=
 =?utf-8?B?bjR0MXA0NkpDUWwyZUVCOWo1VG9VSWVvait1ZzVkV0ErLzhxNE5WVmsya2dU?=
 =?utf-8?B?Z0pSOXBsRDc5Tk5pZXZjWStWcENxUG04aTNScVl6dkdsY2kxN1Y0cUZEd3hi?=
 =?utf-8?B?R1c1dk9sQmw0Qmp0WHA4U3RRK1Nkb1F1MEFIK1BhaEtWSUpvSVhqVDRpdCtI?=
 =?utf-8?B?M1g0OVB5am9xRmJpWGhuVFN4Y2JNN3A2Zkw2UjEyVlhMRS9rU3ErbUJkYjRK?=
 =?utf-8?B?QVRBQ0t0VmdBYTBWK2VTdDJGZEdLTHZWSHVNblRTZ2loM1AvOGgyYjk2V3Az?=
 =?utf-8?B?UDhVR0hacGxxVklGVStNV29BWmNva3R6MndzS213QkdDZFBVRUFFZGVTWkZI?=
 =?utf-8?B?dUNxMjR5VDhXV21wR3g5QUZXRW5zRVd5K0ZvZFA4d2RpTC9OMGhRMzJndlN1?=
 =?utf-8?B?aVJ1aW5aZWxmeHB1UmljeTkvczRBM1htS0dnOVRYb0NyTjlubWFLSmtmM3Jr?=
 =?utf-8?B?a0oraW82QzZwSG96WWliWlV1S1p3Sk04NTFmc3owT3dEWkVSRXBtTGVZRlpo?=
 =?utf-8?B?TmwvS010bWJBdE1Vblp0NFowVlR0Qm4wcFlOdXJseW1adkFoV0lGUmM5VjBk?=
 =?utf-8?B?QUpha1Myc0l3VS81ckpXK25ZRXpoYXVEcllNVjcvTkxWdTNnQlJORkJKVUdI?=
 =?utf-8?B?dnJrVE9TazVoT1IrWTBqUWlMVWZ3K09xM2NncTRhaWdSeDhiREhzdjY4ckg4?=
 =?utf-8?B?eVk5TDFlMWJnREVmY21TeVovQklLQkh0UlMwd2gxYnJ5a2VZdUpSRHdrbTdi?=
 =?utf-8?B?MFFqeHpNUnpPdS8waUkrWHNLQnk2bXgyVWxJN0J0YjhObExzNHprNTBJMlhl?=
 =?utf-8?B?NW9ueG1NVnpsV0RtcHhsMkc5bllhazdENEg0WDY3UXpHbXBoS1YzZnFweEl2?=
 =?utf-8?B?RUpvUDdvRDM0bFplU0RLMUhNUWNNcUcxQnFUejhoeDNHdGVvQ3FoUWtIdWFj?=
 =?utf-8?B?U045T0Z2SW5Idk8zdFpHd1RvNFIvNlhQV2p5RFA2Slc0OEdveFJod2MvRW15?=
 =?utf-8?B?MWRMWVR5YVJVQnR6L3JKNURkYTB3endJRGJrbERFcWF0MVYxN05Mc2Q5R2FO?=
 =?utf-8?B?dG9rN1RxOVhlaVl5ZHZ5ZFpod2IxaTNKODRpNjZrSWxRK2FKMm5ub0Z5OVYy?=
 =?utf-8?B?YWRsUlZWOU9hbXBtQmN5aTUwSzdmL3FiSW9MWVhKeS9leUNLM0VCU0tkTjBn?=
 =?utf-8?B?cjdlM3JqOGJBc0FJeXlUbW9rTG9IblpwZ1JxMFhLayttV1ZncThNbVU2ZCtv?=
 =?utf-8?B?MCtRZlFHS25FTUNNdUp6eFN2VFBxQkdLZjZ0dDVCazEvbFhZTGpscHRlL29j?=
 =?utf-8?B?a2dkVnk5anZFb0srbDBLN1FFMWNYK3FsdVV3ay80R1hFb3JQVlhFYWZ0bU9R?=
 =?utf-8?B?ZndIMXRTVkcxekp0R0FTeXlYL21WOGh5SHpaMnNuOUt1bVFWeTZrTDRPWVI3?=
 =?utf-8?Q?iVkpQt8hqewEoy62hUGXaYU2eh4KqHLNWl/nOu09QyrM?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4dd367-e15b-4118-3694-08dbf1b1bae2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6467.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 14:36:25.2806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QvE/zST2xKWwR05ouS9QEOLjDRA+ZSgqZ8MaTbL7WWsOdiw+cNvxmM66Rsi37C5aNseEs2NqfZ87OyXvWAHYmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7408

On 30.11.23 14:48, Greg Kroah-Hartman wrote:
Hi,

> usb-serial should probably change, but given the fact that no one has
> noticed this in the 20+ years it has been like this, is it really
> needed?  :)

I am afraid I need to point out that usb-serial has been changed _this_ _year_
to return -ENOTTY. CDC-ACM being also in this situation unfortunately
I need to decide between one of the alternatives.

	Regards
		Oliver

